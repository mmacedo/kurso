require 'i18n_eltiro/mapado/bazo'

module I18nEltiro
  module Mapado
    class Dividitoj < Bazo
      agordi do
        al 'aliaj.dividitoj' do
          mapi 'lecionoj.leciono01.l035', 'vortaro'
          mapi 'lecionoj.leciono01.l069', 'rimarkigo'
          mapi 'lecionoj.leciono01.l099', 'traduku'
        end
      end
    end

    class Redundoj < Bazo
      agordi do
        de 'lecionoj.leciono02' do
          forigi 'l007' # rimarkigo
          forigi 'l008' # rimarkigo
          forigi 'l157' # vortaro
          forigi 'l236' # traduku
        end
        de 'lecionoj.leciono03' do
          forigi 'l009' # vortaro
          forigi 'l010' # traduku
          forigi 'l013' # rimarkigo
        end
      end
    end
  end
end
