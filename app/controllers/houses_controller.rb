class HousesController < ApplicationController
  def new
		@house = House.new
  end
	
	def show
		@house = House.find(params[:id])
	end

	def create
		@house = House.new(name: params[:house][:name], admin_id: current_user.id)
		if @house.save
			redirect_to @house
		else
			render 'new'
		end
	end
end
