module ApplicationHelper
  def string_slice_0to20(text)
    text.slice(0,20)
  end

  def string_slice_0to15(text)
    text.slice(0,15)
  end

  def full_title(page_title = '')
    base_title = 'Iam'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
