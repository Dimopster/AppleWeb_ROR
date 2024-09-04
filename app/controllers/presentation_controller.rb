class PresentationController < ApplicationController
    def gadget
        @username = session[:username]
        @email = session[:email]
    end
end