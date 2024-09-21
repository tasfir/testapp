class DistrictsController < ApplicationController
  def index

    # Start with the base query for districts joining translations
    query = District.joins(:translations)
                    .where(translations: { locale: 'bn', key: 'name' })
                    .select('districts.id, translations.value AS name')

    # Add the division_id condition if present
    query = query.where(division_id: params[:division_id]) if params[:division_id].present?

    @districts = query

    # render json: @districts.pluck(:id, :name)
    render json: @districts.map { |district| { id: district.id, name: district.name } }
  end
end
