require 'rails_helper'

RSpec.describe User, :type => :model do 
	before(:each) do
		@user=User.new
	end

	it "has many trips" do
		$user = User.reflect_on_association(:trips)
		$user.macro.should == :has_many
	end

	it ":email should not be null" do
 		@user.email = nil
 		@user.save.should == false
	end

	it ":password should not be null" do
 		@user.password = nil
 		@user.save.should == false
	end

	it {should respond_to(:name)}
	it {should respond_to(:surname)}
	it {should respond_to(:bithday)}
	it {should respond_to(:address)}

	#it { should validate_uniqueness_of(:email) }
	
end