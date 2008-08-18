module StylesheetsHelper

  def ie6_stylesheet name = "ie6"
    "<!--[if lt IE 7]><link rel=\"stylesheet\" type=\"text/css\" href=\"/stylesheets/#{name}.css\" /><![endif]-->"
  end
  
  def ie7_stylesheet name = "ie7"
    "<!--[if IE 7]><link rel=\"stylesheet\" type=\"text/css\" href=\"/stylesheets/#{name}.css\" /><![endif]-->"
  end
  
  def ie_stylesheet name = "ie"
    "<!--[if IE]><link rel=\"stylesheet\" type=\"text/css\" href=\"/stylesheets/#{name}.css\" /><![endif]-->"
  end
  
end