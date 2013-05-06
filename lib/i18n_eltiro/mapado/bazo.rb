require 'i18n_eltiro/mapado/dsl'

module I18nEltiro
  module Mapado
    class Bazo
      class << self
        # DSL vokoj de ĉiuj filoj klasoj
        @@vokoj = []

        # Reludas vokoj por la kunteksto
        def kuri_mapoj!(lingvo, kunteksto)
          return if @@vokoj.nil?
          Dsl.new(lingvo, kunteksto).el 'al_fari' do
            @@vokoj.each do |(komando, bloko, args)|
              send(komando, *args, &bloko)
            end
          end
          purigi!(kunteksto)
        end

        # Replikas la DSL komandoj, sed nur rekordas vokoj
        class_eval do
          Dsl.komandoj.each do |komando|
            define_method(komando) do |*args, &bloko|
              @@vokoj << [komando, bloko, args]
            end
          end
        end

        private
        def purigi!(enhavo)
          enhavo.delete_if do |klavo|
            # Forigas meta propaĵoj
            klavo.to_s =~ /\A__/
          end
          enhavo.each do |(klavo, valoro)|
            next unless valoro.is_a? Hash
            # Rekursias en nodo
            purigi! valoro
            # Forĵetas nodo se malplena
            enhavo.delete(klavo) if valoro.empty?
          end
          enhavo
        end
      end
    end
  end
end
