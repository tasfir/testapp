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

    # Fetch divisions with translations in 'en'
    @districts = District.joins(:translations)
                         .where(translations: { locale: "bn", key: "name" })
                         .select("districts.*, translations.value as name")
  end


  # POST /parties
  def create

    # Fetch the district using the provided district_id
    district = District.find(params[:party][:district_id])

    # If the district is found, get the thana_id
    division_id = district.division_id if district

    # Create the party with the thana_id
    @party = Party.new(party_params.merge(division_id: division_id))

    # @party = Party.new(party_params)
    if @party.save
      redirect_to @party, notice: "Party was successfully created."
    else
      # Fetch divisions with translations in 'en'
      @divisions = Division.joins(:translations)
                           .where(translations: { locale: "bn", key: "name" })
                           .select("divisions.*, translations.value as name")

      render :new
    end
  end

  # GET /parties/:id/edit
  def edit
  end

  # PATCH/PUT /parties/:id
  def update
    if @party.update(party_params)
      redirect_to @party, notice: "Party was successfully updated."
    else
      render :edit
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
    params.require(:party).permit(:division_id, :district_id, :thana_id, :name, :proprietor, :address, :phone, :email, :website, :opening_balance, :remarks, :status)
  end
end
