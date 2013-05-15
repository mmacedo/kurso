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
        # Kongruas malbona escapita, e.g. '\\ "' -> '\\"'
        linio.match(/\\ "/) do |m|
          nova_linio = linio.gsub(/\\ "/, '\"')
          printi_difekto "Malbona escapita kun spacio", dosiero, linio, nova_linio
          linio = nova_linio
        end
        # Kongruas malbona escapita, e.g. '"\\' -> '\\"'
        linio.match(/("\\)([^"\\]|$)/) do |m|
          nova_linio = linio.clone
          nova_linio[Range.new(*m.offset(1))] = '\\"'
          printi_difekto "Malbona escapita kun escapo inversigita", dosiero, linio, nova_linio
          linio = nova_linio
        end
        # Kongruas citilo sen paro
        linio.match(/\A\s* \w+ \s*   =   \s* ("([^"]|\\")*?) \s*\z/mx) do |m|
          nova_linio = linio.gsub(m[1], m[1] + '"')
          printi_difekto "Citilo sen paro", dosiero, linio, nova_linio
          linio = nova_linio
        end
        # Kongruas dua signo '=' ne-escapita
        linio.match(/\A\s* \w+ \s*   =   \s* ([^"].*?=.*?) \s*\z/mx) do |m|
          nova_linio = linio.gsub(m[1], %{"#{m[1]}"})
          printi_difekto "Dua = ne-escapita", dosiero, linio, nova_linio
          linio = nova_linio
        end
        # Kongruas signo '"' ne-escapita
        linio.match(/\A\s* \w+ \s*   =   \s* ("?) (.*?[^\\]".*?) \1 \s*\z/mx) do |m|
          break if m[2].start_with? '"'
          nova_linio = linio.gsub(m[2], m[2].gsub('"', '\"'))
          printi_difekto "Citilo ne-escapita", dosiero, linio, nova_linio
          linio = nova_linio
        end
        loop do
          # kongruas signoj '[' kaj ']' ne-escapita
          break unless linio.match(/\A\s* \w+ \s*   =   \s* ( [\[\]] | .*? [^\\] [\[\]] ) /mx) do |m|
            nova_linio = linio.clone
            nova_linio[m.end(1).pred] = "\\#{nova_linio[m.end(1).pred]}"
            printi_difekto "Rektaj krampoj ne-escapita", dosiero, linio, nova_linio
            linio = nova_linio
          end
        end
        linio
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
      print "\033[33mde: \033[31m#{de}\033[0m"
      print "\033[33mal: \033[32m#{al}\033[0m"
    end
  end
end
