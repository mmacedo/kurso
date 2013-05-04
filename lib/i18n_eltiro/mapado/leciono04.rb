require 'i18n_eltiro/mapado/bazo'

module I18nEltiro
  module Mapado
    class Salutoj < Bazo
      agordi do
        atingo 'lecionoj.leciono04' do
          al 'pagxo01' do
            mapi 'l007', 'salutoj'
            mapi 'l404', 'saluto01'
            mapi 'l405', 'saluto02'
            mapi 'l406', 'saluto03'
            mapi 'l407', 'saluto04'
            mapi 'l408', 'saluto05'
            mapi 'l409', 'saluto06'
            mapi 'l410', 'saluto07'
            mapi 'l411', 'saluto08'
            mapi 'l412', 'saluto09'
            mapi 'l011', 'saluto10'
            mapi 'l013', 'saluto11'
            mapi 'l012', 'saluto12'
            mapi 'l014', 'saluto13'
            mapi 'l015', 'saluto14'
          end
        end
      end
    end

    class Tagoj < Bazo
      agordi do
        atingo 'lecionoj.leciono04' do
          al 'pagxo02' do
            mapi 'l020', 'tagoj'
            al 'semajno' do
              mapi 'l317', 'dimanĉo'
              mapi 'l318', 'lundo'
              mapi 'l319', 'mardo'
              mapi 'l320', 'merkredo'
              mapi 'l321', 'ĵaŭdo'
              mapi 'l322', 'vendredo'
              mapi 'l323', 'sabato'
            end
            al 'relativoj' do
              mapi 'l003', 'hieraŭ'
              mapi 'l004', 'hodiaŭ'
              mapi 'l019', 'morgaŭ'
            end
          end
        end
      end
    end

    class Monatoj < Bazo
      agordi do
        atingo 'lecionoj.leciono04' do
          al 'pagxo03.monatoj' do
            mapi 'l021', 'monatoj'
            mapi 'l325', 'januaro'
            mapi 'l326', 'februaro'
            mapi 'l327', 'marto'
            mapi 'l328', 'aprilo'
            mapi 'l329', 'majo'
            mapi 'l330', 'junio'
            mapi 'l331', 'julio'
            mapi 'l332', 'aŭgusto'
            mapi 'l333', 'septembro'
            mapi 'l334', 'oktobro'
            mapi 'l335', 'novembro'
            mapi 'l336', 'decembro'
          end
          al 'pagxo03.datoj' do
            mapi 'l026', 'datoj'
            mapi 'l022', 'datoj-ekzpliko'
          end
        end
      end
    end

    class DemandajFrazoj < Bazo
      agordi do
        atingo 'lecionoj.leciono04' do
          al 'pagxo04.demandaj' do
            mapi 'l010', 'demandaj'
            mapi 'l315', 'demandaj-ekzpliko'
            al 'aserto' do
              mapi 'l298', 'aserto'
              mapi 'l299', 'aserto-frazo'
            end
            al 'demando' do
              mapi 'l300', 'demando'
              mapi 'l301', "demando-frazo"
            end
            al 'respondo' do
              mapi 'l311', 'respondo'
              mapi 'l312', 'respondo-frazo-pozitiva'
              mapi 'l314', 'respondo-frazo-negativa'
            end
          end
        end
      end
    end

    class Vortaro < Bazo
      agordi do
        atingo 'lecionoj.leciono04' do
          al 'pagxo05' do
            mapi 'l361', 'infano'
            mapi 'l360', 'ĵurnalo'
            mapi 'l362', 'kaj'
            mapi 'l363', 'kongreso'
            mapi 'l364', 'kolekti'
            mapi 'l365', 'lando'
            mapi 'l366', 'veni'
            mapi 'l367', 'leciono'
            mapi 'l368', 'lernejo'
            mapi 'l369', 'libro'
            mapi 'l370', 'mejlo'
            mapi 'l371', 'manĝi'
            mapi 'l372', 'monujo'
            mapi 'l373', 'ovo'
            mapi 'l374', 'neŭtrala'
            mapi 'l376', 'poŝtmarko'
            mapi 'l378', 'sandviĉo'
            mapi 'l379', 'sporto'
            mapi 'l380', 'ŝuo'
            mapi 'l383', 'vojaĝi'
          end
        end
      end
    end

    class Tekstokompreno < Bazo
      agordi do
        atingo 'lecionoj.leciono04' do
          al 'pagxo06' do
            mapi 'l008', 'tekstokompreno'
            mapi 'l418', 'tekstokompreno-ekzpliko'
            al 'vortaro' do
              mapi 'l420', 'lerni'
              mapi 'l421', 'tre'
              mapi 'l017', 'antaŭ'
              mapi 'l423', 'interŝanĝi'
              mapi 'l425', 'komenci'
              mapi 'l426', 'facila'
              mapi 'l428', 'alia'
            end
          end
        end
      end
    end

    class Traduku < Bazo
      agordi do
        de 'lecionoj.leciono04' do
          al 'ekzercoj.leciono04.pagxo10' do
            mapi 'l005', 'traduku'
            mapi 'l385', 'frazo01'
            mapi 'l386', 'frazo02'
            mapi 'l387', 'frazo03', escepte: %i[sr]
            mapi 'l388', 'frazo04'
            mapi 'l389', 'frazo05'
            mapi 'l391', 'frazo06'
            mapi 'l392', 'frazo07'
            mapi 'l393', 'frazo08'
            mapi 'l394', 'frazo09'
            mapi 'l395', 'frazo10', escepte: %i[sr]
          end
        end
      end
    end
  end
end
