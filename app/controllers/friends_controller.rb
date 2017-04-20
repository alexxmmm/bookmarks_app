class FriendsController < ApplicationController
  before_action :authorize

  def index
    @friends = current_user.friendlist
  end

  def show; end

  private

  def bookmarks
    return friend.bookmarks.page(params[:page]).per(8) unless params[:search]
    friend.bookmarks.search(params[:search]).page(params[:page]).per(8)
  end

  def friend
    @friend ||= current_user.friendlist.detect {|user| user.id == params[:id].to_i}
  end

  helper_method :bookmarks
end
