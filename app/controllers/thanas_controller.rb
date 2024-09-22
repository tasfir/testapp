class ThanasController < ApplicationController
  def index

    # Start with the base query for thanas joining translations
    query = Thana.joins(:translations)
                    .where(translations: { locale: 'bn', key: 'name' })
                    .select('thanas.id, translations.value AS name')

    # Add the district_id condition if present
    query = query.where(district_id: params[:district_id]) if params[:district_id].present?

    @thanas = query

    # render json: @thanas.pluck(:id, :name)
    render json: @thanas.map { |thana| { id: thana.id, name: thana.name } }
  end
end
