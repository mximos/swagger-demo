class Api::V1::PetsController < ApplicationController
  before_action :set_api_v1_pet, only: [:show, :update, :destroy]

  # GET /api/v1/pets
  def index
    @api_v1_pets = Api::V1::Pet.all

    render json: @api_v1_pets
  end

  # GET /api/v1/pets/1
  def show
    render json: @api_v1_pet
  end

  # POST /api/v1/pets
  def create
    @api_v1_pet = Api::V1::Pet.new(api_v1_pet_params)

    if @api_v1_pet.save
      render json: @api_v1_pet, status: :created, location: @api_v1_pet
    else
      render json: @api_v1_pet.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/pets/1
  def update
    if @api_v1_pet.update(api_v1_pet_params)
      render json: @api_v1_pet
    else
      render json: @api_v1_pet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/pets/1
  def destroy
    @api_v1_pet.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_pet
      @api_v1_pet = Api::V1::Pet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def api_v1_pet_params
      params.fetch(:api_v1_pet, {})
    end
end
