class DistrictsController < ApplicationController
  def index
    @districts = District.where(division_id: params[:division_id])
    render json: @districts.pluck(:id, :name)
  end
end
