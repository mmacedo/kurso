require 'inifile'

module I18nEltiro
  module Legado
    # Legas .trd (INI), do revenas paro kun lingvo kaj enhavo
    def legi(dosiero)
      # legas linojn
      ini_linioj = IO.readlines(dosiero)
      # riparas sintaksaj eraroj antaŭ analizas
      ripari_sintaksaj_eraroj! dosiero, ini_linioj
      # analiza INI linoj en listo de paroj
      ini = IniFile.new(ini_linioj.join).to_h
      # riparas ini analizilo eraroj
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

        # Forigas spacoj
        linio = linio.gsub(/\A [[:space:]]*([\w\-\\.%—]+)[[:space:]]* = [[:space:]]*(.*?)[[:space:]]* \z/mx, '\1=\2')

        # Aldonas citilo
        linio = linio.gsub(/\A ([\w\-\\.%—]+) = ([^"].*?) \z/mx, '\1="\2"')

        # Eltiras nur valor por procezi
        klavo, valoro = linio.match(/\A([\w\-\\.%—]+)="(.*?)"\z/mx)[1..2]

        # Forigas malbonajn signojn el klavo
        klavo = klavo.gsub(/[^\w.](\w\d+)?/, '_')

        # \$ -> \"
        nova_valoro = valoro.gsub(/\\\z/m, '\"')
        if valoro != nova_valoro
          printi_difekto "Malbona escapita (EOL post '\\')", dosiero, valoro, nova_valoro
          valoro = nova_valoro
        end

        # \ " -> \"
        nova_valoro = valoro.gsub(/\\[[:space:]]"/, '\"')
        if valoro != nova_valoro
          printi_difekto "Malbona escapita (spaco inter la '\\' kaj '\"')", dosiero, valoro, nova_valoro
          valoro = nova_valoro
        end

        # "\ -> \"
        nova_valoro = valoro.gsub(/ "\\ ([^"\\=]|\z) /mx, '\"\1')
        if valoro != nova_valoro
          printi_difekto "Malbona escapita ('\\' post '\"')", dosiero, valoro, nova_valoro
          valoro = nova_valoro
        end

        # []=" -> \[\]\=\"
        escapi = '\1' + '\\\\' + '\2'
        nova_valoro = valoro.gsub(/ ([^\\]|\A) ([\[\]="]) /mx, escapi).gsub(/([\[\]="]) ([\[\]="])/mx, escapi)
        if valoro != nova_valoro
          printi_difekto "Egalsigno, citilo aŭ rekta krampo ne-escapita", dosiero, valoro, nova_valoro
          valoro = nova_valoro
        end

        %(#{klavo}="#{valoro}"\n)
      end
    end

    def ripari_analizilo_eraroj!(ini)
      ini.each do |(klavo, valoro)|
        if valoro.is_a? Hash
          ripari_analizilo_eraroj!(valoro)
        else
          ini[klavo] = ripari_analizilo_valoro(valoro)
        end
      end
    end

    def ripari_analizilo_valoro(valoro)
      # Forigas '\'
      valoro.gsub(/ \\ (.) /mx, '\1')
    end

    def printi_difekto(mesaĝo, dosiero, de, al)
      print "\033[33m#{mesaĝo} (#{File.basename(dosiero)})\033[0m\n"
      print "\033[33mde: \033[31m#{de}\033[0m\n"
      print "\033[33mal: \033[32m#{al}\033[0m\n"
    end
  end
end
