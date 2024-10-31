class HomeController < ApplicationController
  before_action :authenticate_person!
  before_action :configure_person

  def home
    @closest_sitters = @person.closest_sitters
                              .includes(:profile_image_attachment, sitter_profile: :species)
                              .first(6)
    @sitters = @person.closest_sitters.includes(:profile_image_attachment, sitter_profile: :species)
  end

  def dashboard
    redirect_to @person.sitter ? pet_sitter_path : home_path
  end
end
