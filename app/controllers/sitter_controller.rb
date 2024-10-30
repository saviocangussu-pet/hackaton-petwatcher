class SitterController < ApplicationController
  before_action :authenticate_person!
  before_action :set_sitter
  before_action :set_sitter_service, :set_available_pets, only: %i[show schedule]

  def schedule
    if @sitter_service.update(permitted_params)
      redirect_to sitter_service_path, notice: 'Sitter Service was successfully updated.'
    else
      render :show
    end
  end

  private

  def permitted_params
    params.require(:sitter_service).permit(:start_date, :end_date, :pet_id).tap do |permitted|
      permitted[:pet_id] = nil unless @pets_available_for_schedule.map(&:last).include?(permitted[:pet_id].to_i)
    end
  end

  def set_available_pets
    @pets_available_for_schedule = current_person.pets.for_species(@sitter.sitter_profile.species).pluck(:name, :id)
  end

  def set_sitter_service
    @sitter_service = @sitter.sitter_services.build
  end

  def set_sitter
    @sitter = Person.sitters.find(params[:id])
  end
end
