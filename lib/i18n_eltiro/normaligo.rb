module I18nEltiro
  module Normaligo
    # Reverkas klavoj kaj apartigas en tri sekcioj
    def normaligi(lingvo, enhavo)
      rezulto = { 'ekzercoj' => {}, 'lecionoj' => {}, 'aliaj' => {} }

      enhavo.each do |sekcio, parametroj|
        # Reverki parametrojn nomojn, fari ĝin pli legebla
        parametroj = Hash[parametroj.map do |klavo, valoro|
          # turni Label12 en l012
          /Label(\d+)/i.match klavo do |m|klavo =
            klavo = klavo.gsub(m[0], "l" + m[1].rjust(3, '0'))
          end
          # turni Frame5 en f05
          /Frame(\d+)/i.match klavo do |m|
            klavo = klavo.gsub(m[0], "f" + m[1].rjust(2, '0'))
          end

          # anstataŭi ĉiujn punktojn kun substrekas
          klavo = klavo.gsub('.', '_')

          [klavo.downcase, valoro]
        end]

        # Procezi ekzercojn
        if m = sekcio.match(/\AEkzerco-(.+)\z/im)
          klavo = m[1]
          # Konverti al listo
          opcioj = parametroj.length.times.map {|i| parametroj[i.to_s] }
          rezulto['ekzercoj']["ekzerco-#{klavo}".downcase] = opcioj
        # Procezi eksplikojn de la lecionoj
        elsif m = sekcio.match(/\ALec(\d{2})\z/im)
          klavo = m[1]
          rezulto['lecionoj']["leciono#{klavo}".downcase] = parametroj
        # Procezi aliajn agordojn
        else
          rezulto['aliaj'][sekcio.downcase] = parametroj
        end
      end
      { 'al_fari' => rezulto, 'ekzercoj' => {}, 'lecionoj' => {}, 'aliaj' => {} }
    end
  end
end
