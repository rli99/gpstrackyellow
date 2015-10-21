require 'rails_helper'

RSpec.describe User, :type => :model do 
	before(:each) do
		@user=User.new
	end

	it "has many trips" do
		$user = User.reflect_on_association(:trips)
		$user.macro.should == :has_many
	end
	it "has many gpsdata" do
		$user = User.reflect_on_association(:gps_data)
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

	it "is invalid with a duplicate eamail address" do
		User.create(
			name: "abc",
			surname: "mmm",
			bithday: "199",
			address: "aaa",
			email: "123@gmail.com",
			password: "123")
		user=User.new(
			name: "abc",
			surname: "mmm",
			bithday: "199",
			address: "aaa",
			email: "123@gmail.com",
			password: "123")
		user.valid?
		expect(user.errors[:email])

	end

	it {should respond_to(:name)}
	it {should respond_to(:surname)}
	it {should respond_to(:bithday)}
	it {should respond_to(:address)}
	it {should respond_to(:role)}

	#it { should validate_uniqueness_of(:email) }
	
end