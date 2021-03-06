require 'parallel'
require 'i18n_eltiro/legado'
require 'i18n_eltiro/normaligo'
require 'i18n_eltiro/mapado'
require 'i18n_eltiro/skribanto'

module I18nEltiro
  LINGVOJ = { ar: "araba", ch: "china", en: "angla", eo: "esperanto", it: "itala", pt: "portugala", hi: "hinda", pl: "pola", sr: "serba", sv: "sveda" }

  def self.lingvoj
    LINGVOJ
  end

  def self.konstrui_skribantojn(radiko, tipoj)
    @skribantoj = []
    @skribantoj << RailsI18nSkribanto.new(radiko.join("config/locales/lecionoj")) if tipoj.include? :yml
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

      @sinsekva = sinsekva
      @skribantoj = I18nEltiro.konstrui_skribantojn(Rails.root, eliga)
    end

    def printi_difektoj
      @trd_dosieroj.each(&method(:legi))
    end

    def konverti
      # Malaktivigas paralelan ekzekuton se elpurigante
      @procezoj = if @sinsekva then 0 else 4 end

      Parallel.each(@trd_dosieroj, in_processes: @procezoj) do |dosiero|
        begin
          # Legas INI
          lingvo, enhavo = legi(dosiero)
          normaligito    = normaligi(lingvo, enhavo)

          # Mapas QT komponantnomojn al rails-i18n ŝlosiloj
          kuri_mapojn!(lingvo.intern, normaligito)

          # Skribas YML
          @skribantoj.each { |skribanto| skribanto.savi(lingvo, normaligito) }
        rescue
          red, reset = "\033[1;31m", "\033[0m"
          print "#{red}Eraro prilaborante '#{File.basename(dosiero)}'!#{reset}\n"
          raise if @sinsekva
        end
      end
    end
  end
end
