class BookmarksController < ApplicationController
  before_action :set_list, only: %i[create]

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      @bookmarks = @list.bookmarks
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    list = @bookmark.list
    # The path in our delete button is bookmark_path, not list_bookmark_path
    # This is to avoid unnessesary params and nested resouces
    # However as we don't have the access to the list_id, better pull it out by assign @bookmark.list to a variable
    # Now we can use it in the list_path of redirect
    @bookmark.destroy
    redirect_to list_path(list), status: :see_other
    # Race condition is a thing!!!!
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
