require 'rails_helper'

RSpec.describe "TripOperation", :type => :request do 
      let!(:admin){
      	@user=create(:user, password: "1234")
      	login_as @user, scope: :user, :run_callbacks=>false
      }
      
      it "successful workflow" do
      	visit users_sign_in_path
      	expect(page).to have_content("Signed in successfully.")

      end
end