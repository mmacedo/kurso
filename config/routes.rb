Kurso::Application.routes.draw do
  lokaĵarojn_ŝablono = I18n.available_locales.map do |locale|
    Regexp.quote(locale)
  end.join("|")

  scope "(:locale)", :locale => Regexp.new(lokaĵarojn_ŝablono) do
    root to: 'cxefa#cxefpagxo'

    get 'lernado', to: 'cxefa#lernado', as: 'lernado'
    get 'helpo',   to: 'cxefa#helpo',   as: 'helpo'
  end
end
