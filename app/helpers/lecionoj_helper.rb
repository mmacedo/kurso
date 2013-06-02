module LecionojHelper
  def eo(teksto)
    content_tag :a, 'href' => '#', 'class' => 'eo' do
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

  def sc_url(user_name, track_name)
    "http://soundcloud.com/#{user_name}/#{track_name}"
  end

  def sc_stream_url(track_id)
    "http://api.soundcloud.com/tracks/#{track_id}/stream?consumer_key=1a3d9ccaa312ca61da9a88bc2ad4a432"
  end
end
