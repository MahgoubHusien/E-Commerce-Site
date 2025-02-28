class UsersController < ApplicationController
    def show
        @user = Current.session.user
        @wishlist_products = @user.wishlist_products

    end
end
