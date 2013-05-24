Kurso::Application.routes.draw do
  lokaĵarojn_ŝablono = I18n.available_locales.sort.map do |locale|
    Regexp.quote(locale)
  end.join("|")

  scope "(:locale)", :locale => Regexp.new(lokaĵarojn_ŝablono) do
    root to: 'cxefa#cxefpagxo'

    get 'leciono1',  to: 'lecionoj#leciono01', as: 'leciono01'
    get 'leciono2',  to: 'lecionoj#leciono02', as: 'leciono02'
    get 'leciono3',  to: 'lecionoj#leciono03', as: 'leciono03'
    get 'leciono4',  to: 'lecionoj#leciono04', as: 'leciono04'
    get 'leciono5',  to: 'lecionoj#leciono05', as: 'leciono05'
    get 'leciono6',  to: 'lecionoj#leciono06', as: 'leciono06'
    get 'leciono7',  to: 'lecionoj#leciono07', as: 'leciono07'
    get 'leciono8',  to: 'lecionoj#leciono08', as: 'leciono08'
    get 'leciono9',  to: 'lecionoj#leciono09', as: 'leciono09'
    get 'leciono10', to: 'lecionoj#leciono10', as: 'leciono10'
    get 'leciono11', to: 'lecionoj#leciono11', as: 'leciono11'
    get 'leciono12', to: 'lecionoj#leciono12', as: 'leciono12'
  end
end
