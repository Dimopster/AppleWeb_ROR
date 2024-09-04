class SessionsController < ApplicationController
    def create
        username = params[:username]
        password = params[:password]
        user = User.find_by(username: username)
    
        if user && user.authenticate(password)
            session[:username] = user.username
            session[:email] = user.email
            redirect_to '/presentation', notice: 'Login successful!'
        else
            flash.now[:alert] = 'Invalid username or password'
        end
    end
end