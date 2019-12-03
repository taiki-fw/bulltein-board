class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  # GET /boards
  # GET /boards.json
  def index
    @pagy, @boards = pagy(Board.all.order(updated_at: :desc))
  end

  def sort
    @sort_num = params[:sort]
    case @sort_num
    when "1"
      @pagy, @boards = pagy(Board.all.order(updated_at: :desc))
      # order(created_at: :desc)
    when "2"
      @pagy, @boards = pagy(Board.left_joins(:comments)
                                .group(:id)
                                .order('COUNT(comments.id) DESC'))
    else
      @pagy, @boards = pagy(Board.all.order(updated_at: :desc))
    end

    respond_to do |format|
      format.js
    end
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    @comments = @board.comments
    @new_comment = Comment.new
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(board_params)

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: 'Board was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: 'Board was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url, notice: 'Board was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_board
    @board = Board.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def board_params
    params.require(:board).permit(:title, :body)
  end
end
