require 'rails_helper'

RSpec.describe GpsDatum, :type => :model do 

	it {should respond_to(:time)}
	it {should respond_to(:latitude)}
	it {should respond_to(:longitude)}
	it {should respond_to(:altitude)}
	it {should respond_to(:accuracy)}
	it {should respond_to(:speed)}
	it {should respond_to(:bearing)}
	
end