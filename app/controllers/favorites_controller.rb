class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    if !Favorite.find_by(book_id: params[:book_id], user_id: current_user.id)
      favorite = current_user.favorites.new(book_id: params[:book_id])
      favorite.save
    end

    redirect_to request.referer
  end

  def destroy
    favorite = Favorite.find_by(book_id: params[:book_id], user_id: current_user.id)
    favorite.destroy

    redirect_to request.referer
  end
end
