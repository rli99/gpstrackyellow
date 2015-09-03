class WelcomeController < ApplicationController

  before_filter :authenticate_user!

  def index
  end

  def map
  	puts "~~~~~~~~~~~~~~~~~~~~~~~~! test puts"
  end
end
