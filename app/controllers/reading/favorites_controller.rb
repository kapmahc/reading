require_dependency 'reading/application_controller'

module Reading
  class FavoritesController < ApplicationController

    def index
      authorize Reading::Favorite.new
      render layout: 'dashboard'
    end

    def create
      fav = Reading::Favorite.new params.permit(:title, :href)
      authorize fav
      fav.user = current_user
      fav.save
      if fav.valid?
        flash[:notice] = ''
      else
        flash[:alert] = fav.errors.inspect
      end
      redirect_to fav.href
    end


    def destroy
      fav = Reading::Favorite.find(params[:id])
      authorize fav

      fav.destroy
      redirect_to favorites_path
    end

  end

end
