module Api
  module V1
    class PetsController < ApplicationController
      before_action :set_pet, only: [:show, :update, :destroy]

      # GET /api/v1/pets
      def index
        @pets = Pet.all

        render json: @pets
      end

      # GET /api/v1/pets/1
      def show
        render json: @pet.to_json(only: [:id, :name, :status, :photo_url])
      end

      # POST /api/v1/pets
      def create
        @pet = Pet.new(pet_params)

        if @pet.save
          render json: @pet.to_json(only: [:id, :name, :status, :photo_url]), status: :created
        else
          render json: @pet.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/pets/1
      def update
        if @pet.update(pet_params)
          render json: @pet
        else
          render json: @pet.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/pets/1
      def destroy
        @pet.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_pet
          @pet = Pet.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def pet_params
          params.fetch(:pet).permit(:name, :status, :photo_url)
          # .permit(:name, :status, :photo_url)
        end
    end
  end
end
