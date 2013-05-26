I18nEltiro::Mapado.agordi do
  # dividitaj
  al 'aliaj.dividitoj' do
    mapi('lecionoj.leciono01.l035', 'vortaro')   { |obj| obj.gsub(/:\s*\z/m, '') }
    mapi('lecionoj.leciono01.l069', 'rimarkigo') { |obj| obj.gsub(/:\s*\z/m, '') }
    mapi('lecionoj.leciono01.l099', 'traduku')   { |obj| obj.gsub(/:\s*\z/m, '') }
    mapi 'lecionoj.leciono04.l008', 'tekstokompreno'
  end

  # redundaj
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
  el 'lecionoj.leciono05' do
    forigi 'l008' # traduku
    forigi 'l018' # vortaro
    forigi 'l022' # rimarkigo
  end
  el 'lecionoj.leciono07' do
    forigi 'l002' # tekstokompreno
  end

  # lingvo
  mapi 'aliaj.traduko.lingvo' do |obj|

    # kiel 'العربية — araba' aŭ 'Русский — rusa_1'
    if m = obj.match(/\A (.*?) \s*[\-—]\s* ([a-zĉĝĥĵŝŭ]+a)(_\d)? \z/xm)
      denaska, esperanta = m[1..2]
    # kiel 'persa - پارسی'
    elsif m = obj.match(/\A ([a-zĉĝĥĵŝŭ]+a) \s*[\-—]\s* (.*?) \z/xm)
      esperanta, denaska = m[1..2]
    # kiel '中文(ĉina)'
    elsif m = obj.match(/\A (.*?) \s* \( ([a-zĉĝĥĵŝŭ]+a) \) \z/xm)
      denaska, esperanta = m[1..2]
    # kiel 'Esperanto'
    else
      denaska, esperanta = obj, obj
      esperanta, denaska = "esperanto", nil if esperanta == "Esperanto"
    end
    meti 'aliaj.lingvo.denaska', denaska unless denaska.nil?
    meti 'aliaj.lingvo.esperanta', esperanta
  end
end
