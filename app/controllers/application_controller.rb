class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  PARAMETER_KEYS = [:name, :phone, :sitter, { location_attributes: %i[latitude longitude] }].freeze
  SITTER_PARAMETER_KEYS = [:rate, :description, species_ids: []].freeze

  protected

  def after_sign_in_path_for(person)
    person.sitter ? pet_sitter_path : dashboard_path
  end

  def configure_permitted_parameters
    keys = PARAMETER_KEYS.dup
    keys.concat([sitter_profile_attributes: SITTER_PARAMETER_KEYS]) if params.dig(:person, :sitter) == '1'

    devise_parameter_sanitizer.permit(:sign_up, keys:)
  end

  def configure_person
    @person = current_person
  end
end
