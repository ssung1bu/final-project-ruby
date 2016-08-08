class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  
  def index
    @posts = current_user.followed_posts
  end

  def show
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
  end

  def update
    @post.update(post_params)
    redirect_to_post_and_set_flash("Successfully updated post #{@post.id}")
  end

  def destroy
    @post.destroy
    redirect_to(posts_url)
    set_flash('The post was deleted')
  end

  def userposts
    @posts = current_user.posts
  end

  def upvote 
    @post.upvote_by current_user
    redirect_to posts_path
  end  

  def downvote
    @post.downvote_by current_user
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def find_post_by_current_user
    @post = current_user.posts.find(params[:id])
  end

  def redirect_to_post_and_set_flash(message)
    redirect_to_and_set_flash(@post, message)
  end

  def post_params
    params[:post].permit(:text, :avatar)
  end

end
