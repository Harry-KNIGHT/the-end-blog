class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :require_admin, only: [:destroy]

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
            if @user.save
                session[:user_id] = @user.id #connecte l'user à l'inscription et redirect sur son profil (voir articles_controller/ create  )
                flash[:success] = "Utilisateur #{@user.username} crée !"
                redirect_to user_path(@user)
            else
                render 'new'
            end
        end

    def edit
    end

    def update
        if @user.update(user_params)
            flash[:success] = "User updated"
            redirect_to articles_path
        else
            render 'edit'
        end
    end

    def destroy
        @user.destroy
        flash[:success] = "Utilisateur et ses articles supprimé frérot"
        redirect_to users_path

    end

    def show
        @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    
    private 

    def user_params
        params.require(:user).permit(:username,:email, :password)
    end
    
    def set_user
        @user = User.find(params[:id])
    end


    def require_same_user
        if current_user != @user and current_user.admin? == false #user et admin seront vérifiés
            flash[:danger] = "Hola muchachos c'est pas ton profil"
            redirect_to root_path
        end
    end

    def require_admin
        if logged_in? and current_user.admin? == false
            flash[:danger] = "Pas possible si t'es pas admin mon ami"
            redirect_to users_path  
        end
    end
end