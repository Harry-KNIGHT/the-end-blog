class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id] 
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
