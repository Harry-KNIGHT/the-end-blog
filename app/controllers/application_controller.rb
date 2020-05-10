class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?

    def current_user
        @current_user ||= User.find(session[:user]) if session[:user] 
    end

    def logged_in?
        !!current_user
    end

    def require_user
        if not logged_in?
            flash[:danger] = "T'es pas connecté frérot"
            redirect_to root_path
        end
    end
end
