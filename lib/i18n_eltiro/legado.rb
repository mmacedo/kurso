require 'inifile'

module I18nEltiro
  module Legado
    # Legas .trd (INI), do revenas paro kun lingvo kaj enhavo
    def legi(dosiero)
      # legas liniojn
      ini_linioj = IO.readlines(dosiero)
      # riparas sintaksajn erarojn antaŭ analizi
      ripari_sintaksaj_eraroj! dosiero, ini_linioj
      # analizas INI liniojn en listo de paroj
      ini = IniFile.new(ini_linioj.join).to_h
      # riparas erarojn de la INI analizilo
      ripari_analizilo_eraroj! ini

      [ ini["Traduko"]["LingvoID"], ini ]
    rescue IniFile::Error => e
      puts "Error processing #{dosiero}:"
      puts e
    end

    private
    def ripari_sintaksaj_eraroj!(dosiero, linioj)
      linioj.map! do |linio|
        # Procezi nur linioj kun duopoj
        next(linio) unless linio.match /\=/

        # Forigas spacojn
        linio = linio.gsub(/\A [[:space:]]*([\w\-\\.%—]+)[[:space:]]* = [[:space:]]*(.*?)[[:space:]]* \z/mx, '\1=\2')

        # Aldonas citilon
        linio = linio.gsub(/\A ([\w\-\\.%—]+) = ([^"].*?) \z/mx, '\1="\2"')

        # Eltiras nur valoron por procesi
        ŝlosilo, valoro = linio.match(/\A([\w\-\\.%—]+)="(.*?)"\z/mx)[1..2]

        # Forigas malbonajn signojn el ŝlosilo
        ŝlosilo = ŝlosilo.gsub(/[^\w.](\w\d+)?/, '_')

        # \$ -> \"
        nova_valoro = valoro.gsub(/\\\z/m, '\"')
        if valoro != nova_valoro
          printi_difekto "Malbona eskapo (EOL post '\\')", dosiero, valoro, nova_valoro
          valoro = nova_valoro
        end

        # \ " -> \"
        nova_valoro = valoro.gsub(/\\[[:space:]]"/, '\"')
        if valoro != nova_valoro
          printi_difekto "Malbona eskapo (spaco inter la '\\' kaj '\"')", dosiero, valoro, nova_valoro
          valoro = nova_valoro
        end

        # "\ -> \"
        nova_valoro = valoro.gsub(/ "\\ ([^"\\=]|\z) /mx, '\"\1')
        if valoro != nova_valoro
          printi_difekto "Malbona eskapo ('\\' post '\"')", dosiero, valoro, nova_valoro
          valoro = nova_valoro
        end

        # []=" -> \[\]\=\"
        eskapi = '\1' + '\\\\' + '\2'
        nova_valoro = valoro.gsub(/ ([^\\]|\A) ([\[\]="]) /mx, eskapi).gsub(/([\[\]="]) ([\[\]="])/mx, eskapi)
        if valoro != nova_valoro
          printi_difekto "Egalsigno, citilo aŭ rekta krampo ne-eskapita", dosiero, valoro, nova_valoro
          valoro = nova_valoro
        end

        %(#{ŝlosilo}="#{valoro}"\n)
      end
    end

    def ripari_analizilo_eraroj!(ini)
      ini.each do |(ŝlosilo, valoro)|
        if valoro.is_a? Hash
          ripari_analizilo_eraroj!(valoro)
        else
          ini[ŝlosilo] = ripari_analizilo_valoro(valoro)
        end
      end
    end

    def ripari_analizilo_valoro(valoro)
      # Forigas '\'
      valoro.gsub(/ \\ (.) /mx, '\1')
    end

    def printi_difekto(mesaĝo, dosiero, de, al)
      red, green, yellow, reset = "\033[31m", "\033[32m", "\033[33m", "\033[0m"
      print "#{yellow}#{mesaĝo} (#{File.basename(dosiero)})#{reset}\n"
      print "#{yellow}el: #{red}#{de}#{reset}\n"
      print "#{yellow}al: #{green}#{al}#{reset}\n"
    end
  end
end
