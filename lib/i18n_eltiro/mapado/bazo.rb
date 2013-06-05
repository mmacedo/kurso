require 'i18n_eltiro/mapado/dsl'

module I18nEltiro
  module Mapado
    class << self
      # Agordo blokoj
      @@blokoj = []

      # Reludas blokoj por la kunteksto
      def kuri_mapoj!(lingvo, kunteksto)
        return if @@blokoj.nil?
        Dsl.new(kunteksto, nil, lingvo).el 'al_fari' do
          @@blokoj.each do |bloko|
            instance_eval(&bloko)
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
