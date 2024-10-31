class PetSitter::PetsController < ApplicationController
  before_action :authenticate_person!

  def show
    @pet = Pet.find(params[:id])
  end
end
