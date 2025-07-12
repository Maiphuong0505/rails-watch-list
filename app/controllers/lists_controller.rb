class ListsController < ApplicationController
  before_action :set_list, only: %i[show]
  def index
    @lists = List.all
    @list = List.new
  end

  def show
    @bookmarks = @list.bookmarks
    @bookmark = Bookmark.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to lists_path
    else
      @lists = List.all
      # redirect_to lists_path, status: :unprocessable_entity
      # Line 19 wouldn't work
      render "lists/index", status: :unprocessable_entity
    end
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
