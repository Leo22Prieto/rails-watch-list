class BookmarksController < ApplicationController
  before_action :find_list, only: %i[new create]
  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    @bookmark.save ? (redirect_to list_path(@list)) : (render :new)
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    redirect_to list_path(@bookmark.list) if @bookmark.destroy
  end

  private

  def find_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end
end
