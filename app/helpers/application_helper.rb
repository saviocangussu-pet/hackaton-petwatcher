module ApplicationHelper
  def nav_link(name, path, options = {})
    class_name = current_page?(path) ? 'nav-link font-weight-bold' : 'nav-link'
    link_to name, path, { class: class_name }.merge(options)
  end
end
