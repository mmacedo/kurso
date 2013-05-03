require 'parallel'
require 'i18n_eltiro/legado'
require 'i18n_eltiro/normaligo'
require 'i18n_eltiro/mapado'
require 'i18n_eltiro/skribanto'

module I18nEltiro
  LINGVOJ = { ar: "araba", ch: "china", en: "angla", eo: "esperanto", it: "itala", pt: "portugala", hi: "hinda" }

  def self.lingvoj
    LINGVOJ
  end

  def self.konstrui_skribantoj(radiko, tipoj)
    @skribantoj = []
    @skribantoj << RailsI18nSkribanto.new(radiko.join("config/locales/views/kurso")) if tipoj.include? :yml
    @skribantoj << ElpurigoSkribanto.new(radiko.join("tmp/locales")) if tipoj.include? :ai
    @skribantoj
  end

  class Konvertilo
    include Legado
    include Normaligo
    include Mapado

    ENIGA_PADO = "vendor/kurso-desktop/tradukoj"

    def initialize(nur: nil, eliga: %i[yml], sinsekva: false)
      eniga = Rails.root.join(ENIGA_PADO)

      if nur.nil?
        @trd_dosieroj = Dir[eniga.join("*.trd")].sort
      else
        ŝablono = nur.map { |locale| LINGVOJ[locale] }.reject(&:nil?).join(",")
        @trd_dosieroj = Dir[eniga.join("{#{ŝablono}}.trd")].sort
      end

      # Malaktivigas paralelan ekzekuton se elpurigante
      @procezoj = if sinsekva then 0 else 4 end

      @skribantoj = I18nEltiro.konstrui_skribantoj(Rails.root, eliga)
    end

    def konverti
      Parallel.each(@trd_dosieroj, in_processes: @procezoj) do |dosiero|
        begin
          # Legas INI
          lingvo, enhavo = legi(dosiero)
          normaligito    = normaligi(enhavo)

          # Mapas QT komponantnomoj al rails-i18n klavoj
          kuri_mapoj!(normaligito)

          # Skribas YML
          @skribantoj.each { |skribanto| skribanto.savi(lingvo, normaligito) }
        rescue
          p "Error processing '#{dosiero}'!"
          raise
        end
      end
    end
  end
end