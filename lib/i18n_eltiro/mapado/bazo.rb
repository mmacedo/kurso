require 'i18n_eltiro/mapado/dsl'

module I18nEltiro
  module Mapado
    class Bazo
      class << self
        @@blokoj = []
        def kuri_mapoj!(lingvo, kunteksto)
          return if @@blokoj.nil?
          @@blokoj.each do |bloko|
            Dsl.new(lingvo, kunteksto).agordi do
              de 'al_fari' do
                instance_eval(&bloko)
              end
            end
          end
          purigi!(kunteksto)
        end

        def agordi(&bloko)
          @@blokoj << bloko
        end

        private
        def purigi!(enhavo)
          enhavo.delete_if do |klavo|
            # Forigas meta propaĵoj
            klavo.to_s =~ /\A__/
          end
          enhavo.each do |(klavo, valoro)|
            next unless valoro.is_a? Hash
            # Rekursias
            purigi! valoro
            # Forĵetas se malplena
            enhavo.delete(klavo) if valoro.empty?
          end
          enhavo
        end
      end
    end
  end
end
