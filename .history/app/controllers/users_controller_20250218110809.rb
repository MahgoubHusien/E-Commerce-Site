class UsersController < ApplicationController
    def show
        @user = Current.session.user
    end
end
