require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


	test "the truth" do
		e = Event.find(1)

  		assert (e.transportation == "bus edited" || e.transportation == "car edited")
  	end
end
