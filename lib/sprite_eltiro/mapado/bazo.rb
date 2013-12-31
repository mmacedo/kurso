require 'sprite_eltiro/mapado/dsl'

module SpriteEltiro
  module Mapado
    class << self
      # Agordaj blokoj
      @@blokoj = []

      # Reludas blokojn por la kunteksto
      def kuri_mapojn!(eniga, eliga)
        return if @@blokoj.nil?
        dsl = Dsl.new(eniga, eliga)
        @@blokoj.each do |bloko|
          dsl.instance_eval(&bloko)
        end
        purigi!(eniga)
        purigi!(eliga)
      end

      def agordi(&bloko)
        @@blokoj << bloko
      end

      private
      def purigi!(enhavo)
        enhavo.delete_if do |ŝlosilo|
          # Forigas metan propaĵojn
          ŝlosilo.to_s =~ /\A__/
        end
        enhavo.each do |(ŝlosilo, valoro)|
          next unless valoro.is_a? Hash
          # Rekursias en nodo
          purigi! valoro
          # Forĵetas nodon se malplena
          enhavo.delete(ŝlosilo) if valoro.empty?
        end
        enhavo
      end
    end
  end
end
