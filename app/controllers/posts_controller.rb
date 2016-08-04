class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @posts = current_user.posts
  end

  def show
    find_post
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params.merge(user: current_user))

    if @post.valid?
      redirect_to_post_and_set_flash('Created your new post')
    end
  end

  def edit
    find_post
  end

  def update
    find_post_by_current_user
    @post.update(post_params)
    redirect_to_post_and_set_flash("Successfully updated post #{@post.id}")
  end

  def destroy
    find_post_by_current_user
    @post.destroy
    redirect_to(posts_url)
    set_flash('The post was deleted')
  end

  def following
    @posts = current_user.followed_posts
  end

  def upvote 
    find_post
    @post.upvote_by current_user
    redirect_to posts_path
  end  

  def downvote
    find_post
    @post.downvote_by current_user
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def redirect_to_post_and_set_flash(message)
    redirect_to_and_set_flash(@post, message)
  end

  def post_params
    params[:post].permit(:text, :avatar)
  end

end
