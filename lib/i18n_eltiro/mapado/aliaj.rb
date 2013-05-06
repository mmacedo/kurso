require 'i18n_eltiro/mapado/bazo'

module I18nEltiro
  module Mapado
    class Dividitoj < Bazo
      al 'aliaj.dividitoj' do
        mapi('lecionoj.leciono01.l035', 'vortaro')   { |obj| obj.gsub(/:\s*\z/m, '') }
        mapi('lecionoj.leciono01.l069', 'rimarkigo') { |obj| obj.gsub(/:\s*\z/m, '') }
        mapi('lecionoj.leciono01.l099', 'traduku')   { |obj| obj.gsub(/:\s*\z/m, '') }
      end
    end

    class Redundoj < Bazo
      el 'lecionoj.leciono02' do
        forigi 'l007' # rimarkigo
        forigi 'l008' # rimarkigo
        forigi 'l157' # vortaro
        forigi 'l236' # traduku
      end
      el 'lecionoj.leciono03' do
        forigi 'l009' # vortaro
        forigi 'l010' # traduku
        forigi 'l013' # rimarkigo
      end
      el 'lecionoj.leciono04' do
        forigi 'l018' # vortaro
      end
    end

    class Lingvo < Bazo
      mapi 'aliaj.traduko.lingvo' do |obj|
        denaska, disigilo, esperanta = obj.partition(/\s*—\s*/)
        meti 'aliaj.lingvo.denaska', denaska
        meti 'aliaj.lingvo.esperanta', esperanta unless esperanta.empty?
      end
    end
  end
end
