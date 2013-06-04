require 'awesome_print'
require 'ya2yaml'
require 'spacoj_utilecoj'

module I18nEltiro
  class Skribanto
    def initialize(eliga_dosierujo)
      @eliga_dosierujo = eliga_dosierujo
    end

    def savi(lingvo, enhavo)
      raise "Ankoraŭ ne realigita!"
    end
  end

  class ElpurigoSkribanto < Skribanto
    def savi(lingvo, enhavo)
      # Kreas profunda kopio
      enhavo = Marshal.load(Marshal.dump(enhavo))
      # Kunfandas pritraktatajn kaj pretajn
      enhavo.delete('al_fari').each do |(klavo, enhavo_al_fari)|
        if enhavo.has_key? klavo
          enhavo[klavo].merge!(enhavo_al_fari)
        else
          enhavo[klavo] = enhavo_al_fari
        end
      end
      # Skribas dosierojn
      enhavo.keys.each do |klavo|
        savi_dosiero("#{klavo}.#{lingvo}.debug.txt", enhavo[klavo])
      end
    end

    private
    def savi_dosiero(dosiernomo, enhavo)
      FileUtils.mkdir_p @eliga_dosierujo
      dosiero = File.join(@eliga_dosierujo, dosiernomo)
      IO.write dosiero, ripari_spacojn(enhavo.ai(plain:true, sort_keys:true))
      puts dosiero
    end
  end

  class RailsI18nSkribanto < Skribanto
    def savi(lingvo, enhavo)
      (1..12).each do |i|
        leciono   = "leciono#{i.to_s.rjust(2,'0')}"
        dosierujo = File.join(@eliga_dosierujo, leciono)
        %w[lecionoj ekzercoj].each do |klavo|
          next unless enhavo.has_key? klavo and enhavo[klavo].has_key? leciono
          savi_dosiero lingvo, klavo, dosierujo, Hash[leciono, enhavo[klavo][leciono]]
        end
      end
      if enhavo.has_key? 'aliaj'
        dosierujo = File.join(@eliga_dosierujo, 'aliaj')
        savi_dosiero lingvo, 'aliaj', dosierujo, { 'aliaj' => enhavo['aliaj'] }
      end
    end

    private
    def savi_dosiero(lingvo, klavo, dosierujo, enhavo)
      dosiero  = File.join(dosierujo, "#{klavo}.#{lingvo}.yml")
      enpakita = Hash[lingvo, { 'lecionoj' => enhavo }]
      FileUtils.mkdir_p dosierujo
      IO.write dosiero, ripari_spacojn(enpakita.ya2yaml)
      puts dosiero
    end
  end
end
