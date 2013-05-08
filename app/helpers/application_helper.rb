module ApplicationHelper
  def rimarkigo
    content_tag :div, class:                   'bsdocs-skatolo',
                      'data-skatolo-titolo' => t('dividitoj.rimarkigo') do
      yield
    end
  end

  def li(active, klass = "", &block)
    content_tag(:li, :class => "#{klass} #{if active then 'active' else '' end}", &block)
  end
end
