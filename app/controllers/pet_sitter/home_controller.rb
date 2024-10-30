class PetSitter::HomeController < ApplicationController

  def index
    @closest_pets = Pet.closests(current_person)
  end

  private
end
