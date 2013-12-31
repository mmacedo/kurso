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
      enhavo.delete('al_fari').each do |(ŝlosilo, enhavo_al_fari)|
        if enhavo.has_key? ŝlosilo
          enhavo[ŝlosilo].merge!(enhavo_al_fari)
        else
          enhavo[ŝlosilo] = enhavo_al_fari
        end
      end
      # Skribas dosierojn
      enhavo.keys.each do |ŝlosilo|
        savi_dosieron("#{ŝlosilo}.#{lingvo}.debug.txt", enhavo[ŝlosilo])
      end
    end

    private
    def savi_dosieron(dosiernomo, enhavo)
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
        %w[lecionoj ekzercoj].each do |ŝlosilo|
          next unless enhavo.has_key? ŝlosilo and enhavo[ŝlosilo].has_key? leciono
          savi_dosieron lingvo, ŝlosilo, dosierujo, Hash[leciono, enhavo[ŝlosilo][leciono]]
        end
      end
      if enhavo.has_key? 'aliaj'
        dosierujo = File.join(@eliga_dosierujo, 'aliaj')
        savi_dosieron lingvo, 'aliaj', dosierujo, { 'aliaj' => enhavo['aliaj'] }
      end
    end

    private
    def savi_dosieron(lingvo, ŝlosilo, dosierujo, enhavo)
      dosiero  = File.join(dosierujo, "#{ŝlosilo}.#{lingvo}.yml")
      enpakita = Hash[lingvo, { 'lecionoj' => enhavo }]
      FileUtils.mkdir_p dosierujo
      IO.write dosiero, ripari_spacojn(enpakita.ya2yaml)
      puts dosiero
    end
  end
end
