Kurso::Application.routes.draw do
  lokaĵarojn_ŝablono = I18n.available_locales.sort.map do |locale|
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
      get 'leciono04', to: 'lecionoj#leciono04', as: 'leciono04'
      get 'leciono05', to: 'lecionoj#leciono05', as: 'leciono05'
      get 'leciono06', to: 'lecionoj#leciono06', as: 'leciono06'
      get 'leciono07', to: 'lecionoj#leciono07', as: 'leciono07'
      get 'leciono08', to: 'lecionoj#leciono08', as: 'leciono08'
      get 'leciono09', to: 'lecionoj#leciono09', as: 'leciono09'
      get 'leciono10', to: 'lecionoj#leciono10', as: 'leciono10'
    end
  end
end
