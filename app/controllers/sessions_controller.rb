class SessionsController < ApplicationController

    def new
        
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            flash[:success] = "Connecté amigo"
            session[:user_id] = user
            redirect_to user_path(user)
        else
            flash.now[:danger] = "Identifiants incorrect mon pote"
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "À la prochaine mon pote"
        redirect_to root_path
    end
end