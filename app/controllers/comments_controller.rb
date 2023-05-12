class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  after_action :verify_authorized

  def create
    @new_comment = @post.comments.build(comment_params)

    authorize @new_comment

    @new_comment.user = current_user

    if @new_comment.save
      redirect_back(fallback_location: post_path(@post))
    else
      render 'posts/show', status: :unprocessable_entity
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    authorize @comment

    @comment.destroy

    redirect_back(fallback_location: post_path(@post))
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
