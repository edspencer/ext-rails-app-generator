module SitesHelper
  def should_check_plugin?(site, plugin)
    site.new_record? ? plugin.selected_by_default : site.plugins.include?(plugin)
  end
end
