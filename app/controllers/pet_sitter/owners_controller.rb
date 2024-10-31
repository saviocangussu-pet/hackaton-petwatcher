class PetSitter::OwnersController < ApplicationController
  before_action :authenticate_person!
  before_action :set_owner

  private

  def set_owner
    @owner = Person.owners.find(params[:id])
  end
end
