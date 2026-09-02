class DivisionsController < ApplicationController
  def index
    @divisions = Division.all.sort_by { |d| d.name.to_s }
  end

  def show
    @division = Division.find(params[:id])
    @districts = District.where(division_id: @division.id).sort_by { |d| d.name.to_s }
  end
end
