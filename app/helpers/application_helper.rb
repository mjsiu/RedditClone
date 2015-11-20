module ApplicationHelper
  def authen_token
    html = <<-HTML
      <input type="hidden"
        name="authenticity_token"
        value="#{form_authenticity_token}">
    HTML
    html.html_safe
  end

  def author_or_moderator(post)
    current_user == post.author || current_user == post.moderator
  end
end
