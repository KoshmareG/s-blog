class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, except: %i[index new create]

  def index
    @posts = Post.includes(picture_attachment: :blob).all
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post), notice: I18n.t('controllers.posts.created')
    else
      render 'posts/new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: I18n.t('controllers.posts.updated')
    else
      render 'posts/edit', status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :picture)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
