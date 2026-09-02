class PartiesController < ApplicationController
  before_action :set_party, only: %i[show edit update destroy]

  # GET /parties
  def index
    @parties = Party.all
  end

  # GET /parties/:id
  def show
  end

  # GET /parties/new
  def new
    @party = Party.new
    load_district_and_thana_options
  end

  # POST /parties
  def create
    district = District.find_by(id: params[:party][:district_id])
    @party = Party.new(party_params.merge(division_id: district&.division_id))

    if @party.save
      redirect_to @party, notice: "Party was successfully created."
    else
      load_district_and_thana_options
      render :new, status: :unprocessable_entity
    end
  end

  # GET /parties/:id/edit
  def edit
    load_district_and_thana_options(@party.district_id)
  end

  # PATCH/PUT /parties/:id
  def update
    attrs = party_params

    if params[:party][:district_id].present?
      district = District.find_by(id: params[:party][:district_id])
      attrs = attrs.merge(division_id: district.division_id) if district
    end

    if @party.update(attrs)
      redirect_to @party, notice: "Party was successfully updated."
    else
      load_district_and_thana_options(@party.district_id)
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /parties/:id
  def destroy
    @party.destroy
    redirect_to parties_url, notice: "Party was successfully destroyed."
  end

  private

  # Find party by id
  def set_party
    @party = Party.find(params[:id])
  end

  # Only allow a list of trusted parameters through
  def party_params
    params.require(:party).permit(:district_id, :thana_id, :name, :proprietor, :address, :phone, :email, :website, :opening_balance, :remarks, :status)
  end

  # Load districts (all) and thanas (scoped to a district, if given) with 'bn' translated names for the form selects
  def load_district_and_thana_options(district_id = nil)
    @districts = District.joins(:translations)
                          .where(translations: { locale: "bn", key: "name" })
                          .select("districts.*, translations.value as name")

    @thanas = if district_id.present?
      Thana.joins(:translations)
           .where(district_id: district_id)
           .where(translations: { locale: "bn", key: "name" })
           .select("thanas.*, translations.value as name")
    else
      []
    end
  end
end
