module ApplicationHelper
  def markdown(text)
    # open links in a new window
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: false, link_attributes: {class: 'external', target: '_blank'})
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    # gsub => the markdown can be used as popover content
    Redcarpet::Markdown.new(renderer, options).render(text).gsub(/"/, "'").html_safe
  end
end

