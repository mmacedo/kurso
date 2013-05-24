module ApplicationHelper
  def lingvo_selektado_opcioj
    disponeblaj = I18n.available_locales.sort
    # Lokaĵaro el HTTP_ACCEPT_LANGUAGE, nur lingvo
    preferataj  = controller.env.http_accept_language.user_preferred_languages.map do |lokaĵaro|
      lokaĵaro.scan(/[a-z]{2}/).first.intern
    end.uniq
    # Nur preferataj ke disponeblas, sed ne kuranta, ordigita per prefero
    preferataj = preferataj & disponeblaj - [:eo]
    # Disponebla, sed ne preferata nek kuranta, ordigita per lingvo kodo
    aliaj      = disponeblaj - preferataj - [:eo]

    rezulto = lingvo_opcio(:eo)
    unless preferataj.empty?
      # rezulto += content_tag(:li, "", :class => "divider")
      preferataj.each do |lingvo| rezulto += lingvo_opcio(lingvo) end
    end
    unless aliaj.empty?
      rezulto += content_tag(:li, "", :class => "divider")
      aliaj.each do |lingvo| rezulto += lingvo_opcio(lingvo) end
    end
    rezulto
  end

  def lingvo_nomo(lingvo, nur_esperanta = false)
    denasko   = I18n.t 'lecionoj.aliaj.lingvo.denaska',   locale: lingvo, default: "" unless nur_esperanta
    esperanto = I18n.t 'lecionoj.aliaj.lingvo.esperanta', locale: lingvo
    if nur_esperanta or denasko.empty?
      "#{esperanto.mb_chars.capitalize}"
    else
      "#{esperanto.mb_chars.capitalize} / #{denasko}"
    end
  end

  private

  def lingvo_opcio(lingvo)
    content_tag :li do
      content_tag(:a, lingvo_nomo(lingvo), href: url_for(locale: lingvo, only_path: true))
    end
  end
end
