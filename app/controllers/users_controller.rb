class UsersController < ApplicationController
    def create
        @user = User.new(user_params)
    
        if User.exists?(email: @user.email)
            redirect_to '/login', alert: 'Email is already taken.'
        elsif User.exists?(username: @user.username)
            redirect_to '/login', alert: 'Usename is already taken.'
        elsif @user.save
            redirect_to '/presentation', alert: 'Registration successful!'
        else
            render 'new'
        end
    end
    
    private
    
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
