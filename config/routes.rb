Kurso::Application.routes.draw do
  lokaĵarojn_ŝablono = I18n.available_locales.map do |locale|
    Regexp.quote(locale)
  end.join("|")

  scope "(:locale)", :locale => Regexp.new(lokaĵarojn_ŝablono) do
    root to: 'cxefa#cxefpagxo'

    get 'lernado', to: 'cxefa#lernado', as: 'lernado'
    get 'helpo',   to: 'cxefa#helpo',   as: 'helpo'

    scope :lernado do
      get 'leciono01', to: 'lecionoj#leciono01', as: 'leciono01'
      get 'leciono02', to: 'lecionoj#leciono02', as: 'leciono02'
      get 'leciono03', to: 'lecionoj#leciono03', as: 'leciono03'
    end
  end
end
