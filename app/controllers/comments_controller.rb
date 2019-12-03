class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def show
    @replies = @comment.replies
    @new_reply = Reply.new
  end

  def create
    @board = Board.find(params[:board_id])
    @comment = @board.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        @comments = @board.comments
        format.js { flash[:notice] = 'Comment was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @board = Board.find(params[:board_id])
    @comment.destroy
    respond_to do |format|
      @comments = @board.comments
      format.js { flash[:notice] = 'Comment was successfully destroy.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @board = Board.find(params[:board_id])
      @comment = @board.comments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
