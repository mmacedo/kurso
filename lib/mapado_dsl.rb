class MapadoDsl
  def initialize(el_kunteksto, al_kunteksto = nil, datumo = nil)
    @disigilo = ?.
    @el_kunteksto = el_kunteksto
    @al_kunteksto = al_kunteksto || el_kunteksto
    @datumo       = datumo
  end

  def el(pado, escepte: [], &block)
    kontroli_mankantajn(pado, escepte) do |patro, ŝlosilo|
      krei_novon(pado, akiri(patro, ŝlosilo), @al_kunteksto, @datumo).instance_eval(&block)
    end
  end

  def al(pado, &block)
    krei_novon(pado, @el_kunteksto, akiri(@al_kunteksto, pado, false), @datumo).instance_eval(&block)
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
    kontroli_mankantajn(el, escepte) do |patro, ŝlosilo|
      raise "Pado '#{kunigi_padon @el_kunteksto, el}' ne trovita!" unless patro.has_key? ŝlosilo
      objekto = patro.delete(ŝlosilo)

      if block_given?
        yield(objekto)
      else
        objekto
      end
    end
  end

  def meti(al, objekto)
    pado, ponto, ŝlosilo = al.rpartition(disigilo_regex)
    patro = akiri(@al_kunteksto, pado, false)
    if patro.has_key? ŝlosilo
      if patro[ŝlosilo].is_a? Hash
        raise "Pado '#{kunigi_padon @al_kunteksto, al}' havas filojn nodojn!"
      else
        raise "Duobligita pado '#{kunigi_padon @al_kunteksto, al}' jam havas valoron '#{patro[ŝlosilo]}'!"
      end
    end
    patro[ŝlosilo] = objekto
  end

  private
  def akiri(kunteksto, pado, devas_ekzisti = true)
    pado.split(disigilo_regex).inject(kunteksto) do |nuna_kunteksto, ŝlosilo|
      if nuna_kunteksto.has_key? ŝlosilo
        raise "Pado '#{kunigi_padon nuna_kunteksto, ŝlosilo}' havas scalaran valoron!" unless nuna_kunteksto[ŝlosilo].is_a? Hash
      else
        raise "Pado '#{kunigi_padon nuna_kunteksto, ŝlosilo}' ne trovita!" if devas_ekzisti
        nuna_kunteksto[ŝlosilo] = {}
      end
      nuna_kunteksto[ŝlosilo][:__pado] = kunigi_padon nuna_kunteksto, ŝlosilo
      nuna_kunteksto[ŝlosilo]
    end
  end

  def kunigi_padon(kunteksto, pado)
    if kunteksto.has_key? :__pado
      "#{kunteksto[:__pado]}.#{pado}"
    else
      pado
    end
  end

  def kontroli_mankantajn(el, esceptoj)
    pado, ponto, ŝlosilo = el.rpartition(disigilo_regex)

    if esceptoj.include? @datumo
      patro = akiri(@el_kunteksto, pado, false)
      raise "Lingvo #{@datumo} ne mankas '#{kunigi_padon @el_kunteksto, el}' plu!" if patro.has_key? ŝlosilo
    else
      yield(akiri(@el_kunteksto, pado), ŝlosilo)
    end
  end

  def disigilo_regex
    @disigilo_regex ||= begin
      disigilo = Regexp.quote(@disigilo)
      %r@
        (?<! #{disigilo}   ) # ne sekvas disigilo - negativa rigardi-malantaŭen
        #{disigilo}          # disigilo
        (?! #{disigilo}|\z ) # ne antaŭvenas disigilo aŭ fino de la ŝnuro - negativa rigardi-antaŭen
      @xm
    end
    @disigilo_regex
  end

  protected
  def krei_novon(pado, el_kunteksto, al_kunteksto, datumo)
    self.class.new(el_kunteksto, al_kunteksto, datumo)
  end
end
