require 'rails_helper'
require 'sampledata'

RSpec.describe UsersController, type: :controller do
    describe "GET#index" do
        before do
             @request.env['HTTP_REFERER'] = 'http://localhost:3000/sessions/new'
	       	   @request.env["devise.mapping"] = Devise.mappings[:user]
	       	 @user=FactoryGirl.create(:user)
	       	@admin=FactoryGirl.create(:user,
	       	                          role: "admin")
	       	
        end
        it "lists all the users to admin" do
	       	   sign_in @admin
	       	   get :index
	       	   users=User.all.order("id ASC")
	       	   expect (assigns(:users)).to eq users
        end
        it "alert other user with authencation information" do
            sign_in @user
            get :index
             response.should redirect_to(root_path)
             flash[:alert].should eql("You are not allowed to visit this page.")
        end
    end
    
    describe "GET#show" do
       before do
             @request.env['HTTP_REFERER'] = 'http://localhost:3000/sessions/new'
	       	   @request.env["devise.mapping"] = Devise.mappings[:user]
	       	 @user=FactoryGirl.create(:user)
	       	@admin=FactoryGirl.create(:user,
	       	                          role: "admin")
	       	
        end
        it "alert other user with authencation information" do
            sign_in @user
            get :show, id: @user
             response.should redirect_to(root_path)
             flash[:alert].should eql("You are not allowed to visit this page.")
        end
        it "find the request user" do
            sign_in @admin
            get :show, id: @admin
            expect(assigns(:users)).to eq @admin
        end
    end
    
    describe "POST#create" do
         before do
             @request.env['HTTP_REFERER'] = 'http://localhost:3000/sessions/new'
	       	   @request.env["devise.mapping"] = Devise.mappings[:user]
	       	 @user=FactoryGirl.create(:user)
	       	@admin=FactoryGirl.create(:user,
	       	                          role: "admin")
	       	
        end
        it "alert other user with authencation information" do
            sign_in @user
            user_params={ email: "abcd@example.com",
                                password: "123456789",
                                name: "Jack",
                                surname: "Lee",
                                 role: "user" }
            post :create,user: user_params
            
             #response.should redirect_to(root_path)
             flash[:alert].should eql("You are not allowed to visit this page.")
        end
        it "add a new user with valid information" do
            sign_in @admin
            user_params={ email: "abcd@example.com",
                                password: "123456789",
                                name: "Jack",
                                surname: "Lee",
                                role: "user" }
            expect{ post :create,user: user_params}.to change(User, :count).by(1)
        end
    end
    
    describe "POST#update" do
          before do
             @request.env['HTTP_REFERER'] = 'http://localhost:3000/sessions/new'
	       	   @request.env["devise.mapping"] = Devise.mappings[:user]
	       	 @user=FactoryGirl.create(:user)
	       	@admin=FactoryGirl.create(:user,
	       	                          role: "admin")
	       	
        end
        it "alert other user with authencation information" do
            sign_in @user
            user_params={ email: "abcd@example.com",
                                password: "123456789",
                                name: "Jack",
                                surname: "Lee",
                                role: "admin" }
            post :update,id: @user, user: user_params
            
             #response.should redirect_to(root_path)
             flash[:alert].should eql("You are not allowed to visit this page.")
        end
        it "get the requested user" do
             sign_in @admin
            user_params={ email: "abcd@example.com",
                                #password: "123456789",
                                name: "Jack",
                                surname: "Lee",
                                role: "admin" }
            post :update,id: @user, user: user_params
            expect(assigns(:user)).to eq @user
        end 
        it "change the detail of the specified user" do
             sign_in @admin
            user_params={ email: "abcd@example.com",
                               
                                name: "Jack",
                                surname: "Lee",
                                role: "admin" }
            post :update,id: @user, user: user_params
            	@user.reload
		    	expect(@user.name).to eq("Jack")
		    	expect(@user.surname).to eq("Lee")
		    	expect(@user.email).to eq("abcd@example.com")
		   
		    	expect(@user.role).to eq("admin")
        end
        
        describe "delete#destroy" do
              before do
             @request.env['HTTP_REFERER'] = 'http://localhost:3000/sessions/new'
	       	 @request.env["devise.mapping"] = Devise.mappings[:user]
	       	 tripdata=SampleData.gdata
	        @user=tripdata[0]
	       	@admin=FactoryGirl.create(:user,
	       	                          role: "admin")
	       	 sign_in @admin
              end
          it "get the requested user" do

           delete :destroy, id: @user
            expect(assigns(:user)).to eq @user
        end 
        it "delete the user" do
          expect{ delete :destroy, id: @user}.to change(User, :count).by(-1)
        end 
        it "delete all trips belonging to the user" do
            expect{ delete :destroy, id: @user}.to change(Trip, :count).by(-1)
        end
        it "delete all events related" do
             expect{ delete :destroy, id: @user}.to change(Event, :count).by(-2)
        end
         it "delete all transferzones related" do
             expect{ delete :destroy, id: @user}.to change(TransferZone, :count).by(-3)
        end
         it "delete all intermediatepoints related" do
             expect{ delete :destroy, id: @user}.to change(Intermediatepoint, :count).by(-6)
        end
        end
    end

end
