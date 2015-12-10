module ApplicationHelper

  def textile(text)    
    RedCloth.new(text, [:filter_html]).to_html.html_safe
  end

end
