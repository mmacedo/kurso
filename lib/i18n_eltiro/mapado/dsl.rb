module I18nEltiro
  module Mapado
    class Dsl
      def initialize(de_kunteksto, al_kunteksto = nil)
        @de_kunteksto = de_kunteksto
        @al_kunteksto = al_kunteksto || de_kunteksto
      end

      def agordi(&block)
        instance_eval(&block)
      end

      def de(pado, &block)
        Dsl.new(akiri(@de_kunteksto, pado), @al_kunteksto).agordi(&block)
      end

      def al(pado, &block)
        Dsl.new(@de_kunteksto, akiri(@al_kunteksto, pado, false)).agordi(&block)
      end

      def atingo(pado, &block)
        de(pado) do
          al(pado) do
            agordi(&block)
          end
        end
      end

      def mapi(de, al)
        objekto = forigi(de)
        meti(al, objekto)
      end

      def forigi(de)
        pado, ponto, klavo = de.rpartition(/[.]/)
        enhavo = akiri(@de_kunteksto, pado)
        raise "Pado '#{kunigi_pado @de_kunteksto, de}' ne trovita!" unless enhavo.has_key? klavo
        enhavo.delete(klavo)
      end

      def meti(al, objekto)
        pado, ponto, klavo = al.rpartition(/[.]/)
        patro = akiri(@al_kunteksto, pado, false)
        if patro.has_key? klavo
          if kunteksto[klavo].is_a? Hash
            raise "Pado '#{kunigi_pado @al_kunteksto, al}' havas filojn nodojn!"
          else
            raise "Duobligita pado '#{kunigi_pado @al_kunteksto, al}'!"
          end
        end
        patro[klavo] = objekto
      end

      private
      def akiri(kunteksto, pado, devas_ekzisti = true)
        pado.split(/[.]/).inject(kunteksto) do |nuna_kunteksto, klavo|
          if nuna_kunteksto.has_key? klavo
            raise "Pado '#{kunigi_pado nuna_kunteksto, klavo}' havas scalaran valoron!" unless nuna_kunteksto[klavo].is_a? Hash
          else
            raise "Pado '#{kunigi_pado nuna_kunteksto, klavo}' ne trovita!" if devas_ekzisti
            nuna_kunteksto[klavo] = {}
          end
          nuna_kunteksto[klavo][:__pado] = kunigi_pado nuna_kunteksto, klavo
          nuna_kunteksto[klavo]
        end
      end

      def kunigi_pado(kunteksto, pado)
        "#{kunteksto[:__pado] || ''}.#{pado}"
      end
    end
  end
end
