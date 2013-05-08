module CxefaHelper
  def cxiu_lingvo
    disponeblaj = I18n.available_locales.sort
    preferataj  = controller.http_accept_language.user_preferred_languages.map do |lokaĵaro|
      lokaĵaro.scan(/[a-z]{2}/).first.intern
    end.uniq
    disponeblaj.each do |lingvo|
      selektas = I18n.locale == lingvo
      preferas = preferataj.include?(lingvo)
      yield(lingvo, selektas, preferas)
    end
  end

  def lingvo_nomo(lingvo)
    denasko   = I18n.t 'views.kurso.aliaj.lingvo.denaska',   locale: lingvo, default: ""
    esperanto = I18n.t 'views.kurso.aliaj.lingvo.esperanta', locale: lingvo
    if denasko.empty?
      "#{esperanto.mb_chars.capitalize}"
    else
      "#{esperanto.mb_chars.capitalize} / #{denasko}"
    end
  end
end
