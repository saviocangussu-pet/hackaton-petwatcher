class PetSitter::PetsController < ApplicationController

  def show
    @pet = Pet.find(params[:id])
  end
end
