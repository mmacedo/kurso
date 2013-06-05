class MapadoDsl
  def initialize(el_kunteksto, al_kunteksto = nil, datumo = nil)
    @disigilo = ?.
    @el_kunteksto = el_kunteksto
    @al_kunteksto = al_kunteksto || el_kunteksto
    @datumo       = datumo
  end

  def el(pado, escepte: [], &block)
    kontroli_mankantaj(pado, escepte) do |patro, klavo|
      krei_novo(pado, akiri(patro, klavo), @al_kunteksto, @datumo).instance_eval(&block)
    end
  end

  def al(pado, &block)
    krei_novo(pado, @el_kunteksto, akiri(@al_kunteksto, pado, false), @datumo).instance_eval(&block)
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
    kontroli_mankantaj(el, escepte) do |patro, klavo|
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
    pado, ponto, klavo = al.rpartition(disigilo_regexp)
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
    pado.split(disigilo_regexp).inject(kunteksto) do |nuna_kunteksto, klavo|
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

  def kontroli_mankantaj(el, esceptoj)
    pado, ponto, klavo = el.rpartition(disigilo_regexp)

    if esceptoj.include? @datumo
      patro = akiri(@el_kunteksto, pado, false)
      raise "Lingvo #{@datumo} ne mankas '#{kunigi_pado @el_kunteksto, el}' plu!" if patro.has_key? klavo
    else
      yield(akiri(@el_kunteksto, pado), klavo)
    end
  end

  def disigilo_regexp
    @disigilo_regexp ||= begin
      disigilo = Regexp.quote(@disigilo)
      %r@
        (?<! #{disigilo}   ) # ne sekvas disigilo - negativa rigardi-malantaŭen
        #{disigilo}          # disigilo
        (?! #{disigilo}|\z ) # ne antaŭvenas disigilo aŭ fino de la ŝnuro - negativa rigardi-antaŭen
      @xm
    end
    @disigilo_regexp
  end

  protected
  def krei_novo(pado, el_kunteksto, al_kunteksto, datumo)
    self.class.new(el_kunteksto, al_kunteksto, datumo)
  end
end
