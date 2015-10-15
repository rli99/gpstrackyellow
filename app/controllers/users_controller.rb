class UsersController < ApplicationController
      #before_filter :check_logged_in, :only => [:home, :destroy, :update]
    
    def index
        if current_user
            if current_user.role != 'admin'
                redirect_to root_path, alert: 'You are not allowed to visit this page.'
            end
        else
            redirect_to root_path, alert: 'You are not allowed to visit this page.'
        end
        @users = User.all.order("id ASC")
    end
    def show
        if current_user
            if current_user.role != 'admin'
                redirect_to root_path, alert: 'You are not allowed to visit this page.'
            end
        else
            redirect_to root_path, alert: 'You are not allowed to visit this page.'
        end
        @users = User.find(params[:id])
    end
    def new
        if current_user
            if current_user.role != 'admin'
                redirect_to root_path, alert: 'You are not allowed to visit this page.'
            end
        else
            redirect_to root_path, alert: 'You are not allowed to visit this page.'
        end
        @user = User.new
    end
    def create
        if current_user
            if current_user.role != 'admin'
                redirect_to root_path, alert: 'You are not allowed to visit this page.'
            end
        else
            redirect_to root_path, alert: 'You are not allowed to visit this page.'
        end
        @user = User.new(user_params)
        if @user.save
            redirect_to "/users", :notice => "User has been created"
        else
            render "new"
        end
        
    end
    
    
    def edit
        if current_user
            if current_user.role != 'admin'
                redirect_to root_path, alert: 'You are not allowed to visit this page.'
            end
        else
            redirect_to root_path, alert: 'You are not allowed to visit this page.'
        end
        @user = User.find(params[:id])
    end
    
    def update
        if current_user
            if current_user.role != 'admin'
                redirect_to root_path, alert: 'You are not allowed to visit this page.'
            end
        else
            redirect_to root_path, alert: 'You are not allowed to visit this page.'
        end
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            redirect_to users_path, :notice => "User has been updated."
        else
            render "edit"
        end
    end
    	
    def destroy
    @user = User.find(params[:id])
    trips = @user.trips
    trips.each do |t|
        events = t.events
        events.each do |e|
            e.intermediatepoints.destroy_all
            e.transfer_zones.destroy_all
            e.destroy 
        end
        t.destroy
    end
    gpsdata = @user.gps_data
    gpsdata.destroy_all
    @user.destroy
    redirect_to users_path, :notice => "User has been deleted."
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
