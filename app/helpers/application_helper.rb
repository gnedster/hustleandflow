module ApplicationHelper
  def cp(path)
    "active" if current_page?(path)
  end

  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end
end
