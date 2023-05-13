class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[edit update destroy]

  after_action :verify_authorized, except: %i[index show]
  after_action :verify_policy_scoped, only: %i[index show]

  def index
    post_filter = params[:filter] == 'user_posts' ? current_user.posts : Post

    @posts = policy_scope(post_filter).includes(:user, picture_attachment: :blob).page(params[:page])
  end

  def show
    @post = policy_scope(Post).find(params[:id])
    @new_comment = @post.comments.build
  end

  def new
    @post = current_user.posts.build

    authorize @post
  end

  def create
    @post = current_user.posts.build(post_params)

    authorize @post

    if @post.save
      redirect_to post_path(@post), notice: I18n.t('controllers.posts.created')
    else
      render 'posts/new', status: :unprocessable_entity
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post

    if @post.update(post_params)
      redirect_to post_path(@post), notice: I18n.t('controllers.posts.updated')
    else
      render 'posts/edit', status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post

    @post.destroy

    redirect_to root_path, notice: I18n.t('controllers.posts.deleted')
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :picture)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
