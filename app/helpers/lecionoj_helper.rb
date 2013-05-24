module LecionojHelper
  def eo(teksto)
    content_tag :a, 'href' => '#', 'class' => 'eo auxdi' do
      ikono = content_tag(:i, "", 'class' => 'icon-volume-up')
       "#{teksto} ".html_safe + ikono
    end
  end

  # `localize` pro nombroj
  def l2(n)
    number_with_delimiter(n, delimiter: " ", separator: ",")
  end

  # bela skatolo kun "rimarkigo" legenda
  def rimarkigo
    content_tag :div, 'class'               => 'bs-docs-skatolo',
                      'data-skatolo-titolo' => t('lecionoj.aliaj.dividitoj.rimarkigo') do
      yield
    end
  end
end
