class UsersController < ApplicationController
    def show
        @user = current_user
        @wishlist_products = @user.wishlist_products
      end
      
end
