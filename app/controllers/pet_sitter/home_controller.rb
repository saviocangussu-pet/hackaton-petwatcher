class PetSitter::HomeController < ApplicationController
  before_action :authenticate_person!

  def index
    @closest_pets = Pet.closests(current_person)
  end
end
