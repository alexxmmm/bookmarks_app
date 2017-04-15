class BookmarksController < ApplicationController
  before_action :authorize

  def index
    @bookmark = Bookmark.new
    @url = LinkThumbnailer.generate('http://stackoverflow.com')
  end

  def create
    @bookmark = current_user.bookmarks.create(bookmark_params)
    render(:new) && return unless @bookmark.save
  end

  def destroy
    @bookmark = current_user.bookmarks.find(params[:id])
    @bookmark.destroy
  end

  private

  def bookmark_params
    params.fetch(:bookmark).permit(:url)
  end

  def bookmarks
    return current_user.bookmarks.page(params[:page]).per(8) unless params[:search]
    current_user.bookmarks.search(params[:search]).page(params[:page]).per(8)
  end

  helper_method :bookmarks
end
