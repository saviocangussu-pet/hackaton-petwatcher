class HomeController < ApplicationController
  before_action :authenticate_person!
  before_action :configure_person

  def dashboard
    @closest_sitters = @person.closest_sitters.includes(sitter_profile: :species)
  end
end
