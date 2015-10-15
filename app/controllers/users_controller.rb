class UsersController < ApplicationController
      #before_filter :check_logged_in, :only => [:home, :destroy, :update]
  
    
    def index
         @users = User.all.order("id ASC")
    end
    def show
        @users = User.find(params[:id])
    end
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to "/users", :notice => "User has been created"
        else
            render "new"
        end
        
    end
    
    
    def edit
    @user = User.find(params[:id])
    end
    
    def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
        redirect_to users_path, :notice => "User has been updated"
    else
        render "edit"
    end
    end
    	
      
    
  
    def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, :notice => "User has been deleted"
    end
    
    private
     def check_logged_in
        authenticate_or_request_with_http_basic("Users") do |role|
            role == "admin"
        end
     end
    def user_params
      params.require(:user).permit(:email, :password, :name, :surname, :role)
    end
   
end
