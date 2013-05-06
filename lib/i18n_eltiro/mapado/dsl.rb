module I18nEltiro
  module Mapado
    class Dsl
      KOMANDOJ = %i[el al atingo mapi forigi meti]

      def self.komandoj
        KOMANDOJ
      end

      def initialize(lingvo, el_kunteksto, al_kunteksto = nil)
        @lingvo       = lingvo
        @el_kunteksto = el_kunteksto
        @al_kunteksto = al_kunteksto || el_kunteksto
      end

      def el(pado, &block)
        Dsl.new(@lingvo, akiri(@el_kunteksto, pado), @al_kunteksto).instance_eval(&block)
      end

      def al(pado, &block)
        Dsl.new(@lingvo, @el_kunteksto, akiri(@al_kunteksto, pado, false)).instance_eval(&block)
      end

      def atingo(pado, &block)
        el(pado) do
          al(pado) do
            instance_eval(&block)
          end
        end
      end

      def mapi(el, al, escepte: [])
        if escepte.include? @lingvo
          pado, ponto, klavo = el.rpartition(/[.]/)
          patro = akiri(@el_kunteksto, pado)
          raise "Lingvo #{@lingvo} ne mankas '#{kunigi_pado @el_kunteksto, el}' plu!" if patro.has_key? klavo
        else
          objekto = forigi(el)
          meti(al, objekto)
        end
      end

      def forigi(el)
        pado, ponto, klavo = el.rpartition(/[.]/)
        enhavo = akiri(@el_kunteksto, pado)
        raise "Pado '#{kunigi_pado @el_kunteksto, el}' ne trovita!" unless enhavo.has_key? klavo
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
