require 'i18n_eltiro/mapado/bazo'

module I18nEltiro
  module Mapado
    class Alfabeto < Bazo
      agordi do
        atingo 'lecionoj.leciono01' do
          al 'pagxo01' do
            mapi 'l004', 'alfabeto-titolo'
            mapi 'l002', 'alfabeto-ekspliko'
          end
        end
      end
    end

    class Auxdkompreno01 < Bazo
      agordi do
        de 'lecionoj.leciono01' do
          al 'ekzercoj.leciono01.pagxo02' do
            mapi 'l003', 'auxdkompreno01'
            mapi 'l006', 'auxdkompreno01-instrukcio'
          end
        end
      end
    end

    class PersonajPronomoj < Bazo
      agordi do
        atingo 'lecionoj.leciono01' do
          al 'pagxo03' do
            mapi 'l012', 'personaj-pronomoj'
            al 'singularo' do
              mapi 'l131', 'singularo'
              mapi 'l013', 'mi'
              mapi 'l014', 'vi'
              mapi 'l015', 'li'
              mapi 'l016', 'sxi'
              mapi 'l017', 'gxi'
            end
            al 'pluralo' do
              mapi 'l132', 'pluralo'
              mapi 'l018', 'ni'
              mapi 'l019', 'vi'
              mapi 'l020', 'ili'
            end
            al 'specialaj' do
              mapi 'l133', 'specialaj'
              mapi 'l021', 'oni'
              mapi 'l022', 'si'
            end
          end
        end
      end
    end

    class Verboj < Bazo
      agordi do
        atingo 'lecionoj.leciono01' do
          al 'pagxo04' do
            al 'verboj' do
              mapi 'l023', 'verboj'
              mapi 'l024', 'verboj-ekspliko'
              al 'singularo' do
                mapi 'l114', 'mi-estas'
                mapi 'l115', 'li-estis'
                mapi 'l116', 'sxi-estas'
                mapi 'l117', 'gxi-estos'
              end
              al 'ne-singularo' do
                mapi 'l118', 'ni-estas'
                mapi 'l119', 'vi-estis'
                mapi 'l220', 'ili-estas'
                mapi 'l221', 'oni-estos'
              end
            end
            al 'nomoj' do
              mapi 'l025', 'nomoj'
              mapi 'l027', 'nomoj-ekspliko'
              mapi 'l028', 'amiko'
              mapi 'l029', 'frato'
              mapi 'l030', 'kafo'
            end
            al 'adjektivoj' do
              mapi 'l026', 'adjektivoj'
              mapi 'l031', 'adjektivoj-ekspliko'
              mapi 'l032', 'bela'
              mapi 'l033', 'sana'
              mapi 'l034', 'varma'
            end
          end
        end
      end
    end

    class Vortaro < Bazo
      agordi do
        atingo 'lecionoj.leciono01' do
          al 'pagxo05' do
            mapi 'l044', 'amiko'
            mapi 'l045', 'filo'
            mapi 'l046', 'frato'
            mapi 'l047', 'viro'
            mapi 'l048', 'knabo'
            mapi 'l049', 'floro'
            mapi 'l050', 'patro'
            mapi 'l051', 'instruisto'
            mapi 'l052', 'kafo'
            mapi 'l053', 'kuko'
            mapi 'l054', 'lakto'
            mapi 'l055', 'pano'
            mapi 'l056', 'sukero'
            mapi 'l057', 'teo'
            mapi 'l058', 'biskvito'
            mapi 'l060', 'bela'
            mapi 'l061', 'granda'
            mapi 'l062', 'nova'
            mapi 'l063', 'bona'
            mapi 'l064', 'seka'
            mapi 'l065', 'blanka'
            mapi 'l066', 'varma'
            mapi 'l067', 'sana'
          end
        end
      end
    end

    class Pluralo < Bazo
      agordi do
        atingo 'lecionoj.leciono01' do
          al 'pagxo06' do
            mapi 'l036', 'pluralo-titolo'
            mapi 'l037', 'pluralo-ekzpliko'
            al 'singularo' do
              mapi 'l010', 'amiko'
              mapi 'l073', 'patro'
              mapi 'l074', 'floro'
              mapi 'l075', 'bela'
              mapi 'l076', 'sana'
              mapi 'l077', 'bela-floro'
              mapi 'l078', 'sana-patro'
              mapi 'l079', 'bona-amiko'
            end
            al 'pluralo' do
              mapi 'l080', 'amikoj'
              mapi 'l081', 'patroj'
              mapi 'l082', 'floroj'
              mapi 'l083', 'belaj'
              mapi 'l084', 'sanaj'
              mapi 'l085', 'belaj-floroj'
              mapi 'l086', 'sanaj-patroj'
              mapi 'l087', 'bonaj-amikoj'
            end
          end
        end
      end
    end

    class PosedajPronomoj < Bazo
      agordi do
        atingo 'lecionoj.leciono01' do
          al 'pagxo07' do
            mapi 'l040', 'posedaj-pronomoj'
            mapi 'l041', 'posedaj-pronomoj-ekzpliko'
            # personaj pruntita de pagxo 3
            al 'posedaj' do
              mapi 'l011', 'mia'
              mapi 'l070', 'via'
              mapi 'l071', 'ŝia'
              mapi 'l092', 'lia'
              mapi 'l093', 'ĝia'
              mapi 'l094', 'nia'
              mapi 'l072', 'ilia'
            end
            al 'rimarkigo' do
              mapi 'l042', 'posedaj-pronomoj-rimarkigo'
              mapi 'l095', 'mia-amiko'
              mapi 'l096', 'miaj-amikoj'
              mapi 'l097', 'nia-floro'
              mapi 'l098', 'niaj-floroj'
            end
          end
        end
      end
    end

    class Artikolo < Bazo
      agordi do
        atingo 'lecionoj.leciono01' do
          al 'pagxo08' do
            al 'artikolo' do
              mapi 'l038', 'artikolo'
              mapi 'l039', 'artikolo-ekzpliko'
              mapi 'l088', 'la-knabo'
              mapi 'l089', 'la-floroj'
              mapi 'l090', 'la-pano'
              mapi 'l091', 'la-patroj'
              mapi 'l100', 'knabo'
              mapi 'l101', 'floroj'
              mapi 'l102', 'pano'
              mapi 'l103', 'patroj'
            end
            al 'frazoj' do
              mapi 'l043', 'frazoj'
              mapi 'l104', 'frazo01'
              mapi 'l105', 'frazo03'
              mapi 'l106', 'frazo05'
              mapi 'l107', 'frazo02'
              mapi 'l108', 'frazo04'
              mapi 'l109', 'frazo06'
            end
          end
        end
      end
    end

    class Traduku < Bazo
      agordi do
        de 'lecionoj.leciono01' do
          al 'ekzercoj.leciono01.pagxo12' do
            mapi 'l121', 'frazo01'
            mapi 'l122', 'frazo02'
            mapi 'l123', 'frazo03'
            mapi 'l110', 'frazo04'
            mapi 'l125', 'frazo05'
            mapi 'l126', 'frazo06'
            mapi 'l127', 'frazo07'
            mapi 'l128', 'frazo08'
            mapi 'l129', 'frazo09'
            mapi 'l130', 'frazo10'
          end
        end
      end
    end
  end
end