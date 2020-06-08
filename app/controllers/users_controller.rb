class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome to Project2 #{@user.username}, you have successfuly signed up"
            redirect_to articles_path
        else
            render 'new'
        end
    end

    def edit
        
    end

    def update
      
        if @user.update(user_params)
            flash[:notice] = "Your account suceesfuly updated"
            redirect_to @user
        else
            render 'edit'
        end
    end

    def show
        @article = @user.articles.paginate(page: params[:page], per_page: 5)
    end
    
    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def destroy
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:alert] = "Account and all associated articles sucessfully deleted"
        if current_user.admin?
            redirect_to users_path
        else
            redirect_to root_path
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user && !current_user.admin?
            flash[:alert] = "You can only Edit or Delete your own profile"
            redirect_to @user
        end
    end
end