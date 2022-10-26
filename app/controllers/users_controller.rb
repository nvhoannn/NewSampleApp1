class UsersController < ApplicationController
    before_action :find_user, only: [:show, :edit, :update, :destroy]
    before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
    before_action :correct_user, only: [:edit, :update]
    before_action :admin_user, only: :destroy

    def index
        @users = User.all.page params[:page]
      end

    def show
        @user = User.find_by(id: params[:id])

        redirect_to static_pages_home_path unless @user
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            log_in @user
            flash[:success] = "Welcome to the Sample App!"
            redirect_to @user
        else
            flash[:danger] = "Validate failed"
            render :new
        end
    end

    def edit
    end
  
    def update
        if @user.update(user_params)
          flash[:success] = "Updated sucessfully"
          redirect_to @user
        else
          render :edit
        end
    end
    
    def destroy
        @user.destroy
        flash[:success] = "User deleted"
        redirect_to users_url
      end

    private
    def user_params
        params.require(:user).permit :name, :email, :password, 
        :password_confirmation
    end

    def find_user
        @user = User.find_by(id: params[:id])
        redirect_to static_pages_home_path unless @user
    end
    def correct_user
        redirect_to root_url unless current_user?(@user)
      end
    
      def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end

      def admin_user
        redirect_to(root_url) unless current_user.admin?
        end
    end