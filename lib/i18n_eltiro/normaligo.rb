module I18nEltiro
  module Normaligo
    # Reverkas klavoj kaj apartigas en tri sekcioj
    def normaligi(enhavo)
      rezulto = { 'ekzercoj' => {}, 'lecionoj' => {}, 'aliaj' => {} }

      enhavo.each do |sekcio, parametroj|
        # Reverki parametrojn nomojn, fari ĝin pli legebla
        parametroj = Hash[parametroj.map do |klavo, valoro|
          # turni Label12 en l012
          /Label(\d+)/.match klavo do |m|klavo =
            klavo = klavo.gsub(m[0], "l" + m[1].rjust(3, '0'))
          end
          # turni Frame5 en f05
          /Frame(\d+)/.match klavo do |m|
            klavo = klavo.gsub(m[0], "f" + m[1].rjust(2, '0'))
          end

          # anstataŭi ĉiujn punktojn kun substrekas
          klavo = klavo.gsub('.', '_')

          [klavo.downcase, valoro]
        end]

        # Procesi ekzercojn
        if sekcio.start_with? 'Ekzerco-'
          klavo = sekcio.match(/^Ekzerco-(.+)$/)[1]
          # Konverti al listo
          opcioj = parametroj.length.times.map {|i| parametroj[i.to_s] }
          rezulto['ekzercoj']["ekzerco-#{klavo}".downcase] = opcioj

        # Procesi eksplikojn de la lecionoj
        elsif sekcio =~ /^Lec\d{2}$/
          klavo = sekcio.match(/^Lec(\d{2})$/)[1]
          rezulto['lecionoj']["leciono#{klavo}".downcase] = parametroj

        # Procesi aliajn agordojn
        else
          rezulto['aliaj'][sekcio.downcase] = parametroj
        end
      end
      { 'al_fari' => rezulto, 'ekzercoj' => {}, 'lecionoj' => {}, 'aliaj' => {} }
    end
  end
end
