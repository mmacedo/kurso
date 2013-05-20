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

      def el(pado, escepte: [], &block)
        kontroli_mankaj_tradukoj(pado, escepte) do |patro, klavo|
          Dsl.new(@lingvo, akiri(patro, klavo), @al_kunteksto).instance_eval(&block)
        end
      end

      def al(pado, &block)
        Dsl.new(@lingvo, @el_kunteksto, akiri(@al_kunteksto, pado, false)).instance_eval(&block)
      end

      def atingo(pado, escepte: [], &block)
        el(pado, escepte: escepte) do
          al(pado) do
            instance_eval(&block)
          end
        end
      end

      def mapi(el, al=nil, escepte: [], &block)
        forigi(el, escepte: escepte) do |objekto|
          if block_given?
            if al.nil?
              instance_exec(objekto, &block)
            else
              meti(al, instance_exec(objekto, &block))
            end
          else
            raise "Malbona uzo de `mapi`, ĝi bezonas blokon kaj/aŭ padon!" if al.nil?
            meti(al, objekto)
          end
        end
      end

      def forigi(el, escepte: [], &block)
        kontroli_mankaj_tradukoj(el, escepte) do |patro, klavo|
          raise "Pado '#{kunigi_pado @el_kunteksto, el}' ne trovita!" unless patro.has_key? klavo
          objekto = patro.delete(klavo)

          if block_given?
            yield(objekto)
          else
            objekto
          end
        end
      end

      def meti(al, objekto)
        pado, ponto, klavo = al.rpartition(/[.]/)
        patro = akiri(@al_kunteksto, pado, false)
        if patro.has_key? klavo
          if patro[klavo].is_a? Hash
            raise "Pado '#{kunigi_pado @al_kunteksto, al}' havas filojn nodojn!"
          else
            raise "Duobligita pado '#{kunigi_pado @al_kunteksto, al}' jam havas valoron '#{patro[klavo]}'!"
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
        if kunteksto.has_key? :__pado
          "#{kunteksto[:__pado]}.#{pado}"
        else
          pado
        end
      end

      def kontroli_mankaj_tradukoj(el, esceptoj)
        pado, ponto, klavo = el.rpartition(/[.]/)

        if esceptoj.include? @lingvo
          patro = akiri(@el_kunteksto, pado, false)
          raise "Lingvo #{@lingvo} ne mankas '#{kunigi_pado @el_kunteksto, el}' plu!" if patro.has_key? klavo
        else
          yield(akiri(@el_kunteksto, pado), klavo)
        end
      end
    end
  end
end
