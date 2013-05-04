require 'i18n_eltiro/mapado/bazo'

module I18nEltiro
  module Mapado
    class SufiksoIno < Bazo
      atingo 'lecionoj.leciono02' do
        al 'pagxo01' do
          mapi 'l131', 'sufikso-ino'
          mapi 'l132', 'sufikso-ino-ekspliko-1'
          mapi 'l133', 'sufikso-ino-ekspliko-2'
          al 'vortoj' do
            mapi 'l011', 'viro'
            mapi 'l012', 'amiko'
            mapi 'l013', 'filo'
            mapi 'l014', 'patro'
            mapi 'l134', 'virino'
            mapi 'l135', 'amikino'
            mapi 'l136', 'filino'
            mapi 'l137', 'patrino'
          end
          al 'frazoj' do
            mapi 'l138', 'frazo-virino'
            mapi 'l001', 'frazo-amikino'
            mapi 'l016', 'frazo-patrino'
          end
        end
      end
    end

    class Akuzativo < Bazo
      atingo 'lecionoj.leciono02' do
        al 'pagxo02' do
          mapi 'l139', 'akusativo'
          mapi 'l140', 'akusativo-ekzpliko-1'
          mapi 'l019', 'frazo-singulara'
          mapi 'l020', 'frazo-plurala'
          mapi 'l143', 'akusativo-ekzpliko-2'
          mapi 'l144', 'akusativo-rimarkigo-1'
          mapi 'l145', 'akusativo-rimarkigo-2'
        end
      end
    end

    class PrefiksoMal < Bazo
      atingo 'lecionoj.leciono02' do
        al 'pagxo03' do
          al 'prefikso-mal' do
            mapi 'l146', 'prefikso-mal'
            mapi 'l147', 'prefikso-mal-ekspliko'
            mapi 'l148', 'amiko'
            mapi 'l150', 'nova'
            mapi 'l017', 'avara'
            mapi 'l149', 'bela'
            mapi 'l009', 'juna'
            mapi 'l004', 'malamiko'
            mapi 'l006', 'malnova'
            mapi 'l018', 'malavara'
            mapi 'l005', 'malbela'
            mapi 'l010', 'maljuna'
          end
          al 'neado' do
            mapi 'l151', 'neado'
            mapi 'l152', 'neado-ekspliko'
            mapi 'l021', 'frazo01'
            mapi 'l154', 'frazo02'
            mapi 'l155', 'frazo03'
            mapi 'l156', 'frazo04'
          end
        end
      end
    end

    class Muziko < Bazo
      atingo 'lecionoj.leciono02' do
        al 'pagxo04' do
          mapi 'l050', 'muziko'
          mapi 'l049', 'muziko-ekzpliko'
        end
      end
    end

    class Vortaro < Bazo
      atingo 'lecionoj.leciono02' do
        al 'pagxo05' do
          mapi 'l158', 'akvo'
          mapi 'l159', 'ami'
          mapi 'l160', 'amo'
          mapi 'l161', 'birdo'
          mapi 'l162', 'butiko'
          mapi 'l163', 'fari'
          mapi 'l164', 'forgesi'
          mapi 'l165', 'havi'
          mapi 'l166', 'insekto'
          mapi 'l167', 'kapti'
          mapi 'l168', 'lavi'
          mapi 'l169', 'limonado'
          mapi 'l170', 'papero'
          mapi 'l171', 'peti'
          mapi 'l172', 'plumo'
          mapi 'l173', 'porti'
          mapi 'l174', 'pura'
          mapi 'l175', 'renkonti'
          mapi 'l176', 'skribi'
          mapi 'l177', 'sukeri'
          mapi 'l178', 'taso'
          mapi 'l179', 'trinki'
          mapi 'l180', 'trovi'
          mapi 'l181', 'vendi'
          mapi 'l182', 'vidi'
        end
      end
    end

    class Ekzercoj < Bazo
      de 'lecionoj.leciono02' do
        al 'ekzercoj.leciono02.pagxo10' do
          mapi 'tf41_l084', 'ekzpliko'
        end
      end
    end

    class Traduku < Bazo
      de 'lecionoj.leciono02' do
        al 'ekzercoj.leciono02.pagxo11' do
          mapi 'l237', 'frazo01'
          mapi 'l238', 'frazo02'
          mapi 'l022', 'frazo03'
          mapi 'l240', 'frazo04'
          mapi 'l241', 'frazo05'
          mapi 'l242', 'frazo06'
          mapi 'l243', 'frazo07'
          mapi 'l244', 'frazo08'
          mapi 'l245', 'frazo09'
          mapi 'l246', 'frazo10'
        end
      end
    end
  end
end
