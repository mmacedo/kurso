module ApplicationHelper
  def rimarkigo
    content_tag :div, class:                   'bsdocs-skatolo',
                      'data-skatolo-titolo' => t('dividitoj.rimarkigo') do
      yield
    end
  end
end
