class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      CommentsMailer.notify_vendor(@comment.vendor).deliver_now
      redirect_to @comment.vendor, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:like, :content, :vendor_id)
    end
end
