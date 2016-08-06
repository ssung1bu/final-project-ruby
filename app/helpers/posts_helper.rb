module PostsHelper
  def edit_post_link(post)
    button_to('Edit', edit_post_url(post))
  end
end
