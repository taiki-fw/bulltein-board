class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.all.order(updated_at: :desc)
  end

  def sort
    case params[:sort]
    when "1"
      @boards = Board.all.order(updated_at: :desc)
      # order(created_at: :desc)
    when "2"
      @boards = Board.select(:id, :title, :body, 'count(comments.id) AS comments')
                    .joins(:comments)
                    .group('boards.id')
                    .order('comments desc')
    else
      @boards = Board.all.order(updated_at: :desc)
    end

    respond_to do |format|
      format.html { redirect_to @boards, notice: 'this board is sorted'}
      format.js
      format.json { render json: @board, status: 200 }
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
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: 'Board was successfully updated.' }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url, notice: 'Board was successfully destroyed.' }
      format.json { head :no_content }
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
