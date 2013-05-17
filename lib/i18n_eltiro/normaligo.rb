module I18nEltiro
  module Normaligo
    # Reverkas klavoj kaj apartigas en tri sekcioj
    def normaligi(lingvo, enhavo)
      rezulto = { 'ekzercoj' => {}, 'lecionoj' => {}, 'aliaj' => {} }

      # Antaŭ-procezi specialajn okazojn
      if lingvo.intern == :sl
        if enhavo.has_key? 'lec05A' and not enhavo.has_key? 'Lec06'
          enhavo['Lec06'] = enhavo.delete('lec05A')
        else
          raise "Speciala okazo por slovena malsukcesis: renomi [lec05A] al [Lec06]"
        end
        if enhavo.has_key? 'lec07' and enhavo.has_key? 'Lec07'
          enhavo['Lec07'].merge! enhavo.delete('lec07')
        else
          raise "Speciala okazo por slovena malsukcesis: kombini [lec07] en [Lec07]"
        end
      end

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
