class Person::SitterServicesController < ApplicationController
  before_action :authenticate_person!
  before_action :set_person
  before_action :set_sitter_service, only: %i[show edit update destroy]

  def index
    @sitter_services = @person.pets.includes(:sitter_services).map(&:sitter_services).flatten
  end

  def show; end

  def new
    @sitter_service = @person.sitter_services.build
  end

  def create
    @sitter_service = @person.sitter_services.build(sitter_service_params)
    return unless @sitter_service.save

    redirect_to person_sitter_services_path(@person), notice: 'Sitter Service was successfully created.'
  end

  def edit; end

  def update
    if @sitter_service.update(sitter_service_params)
      redirect_to person_sitter_service_path(@person, @sitter_service),
                  notice: 'Sitter Service was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @sitter_service.destroy
    redirect_to person_sitter_services_path(@person), notice: 'Sitter Service was successfully deleted.'
  end

  private

  def set_person
    @person = current_person
  end

  def set_sitter_service
    @sitter_service = @person.sitter_services.find(params[:id])
  end

  def sitter_service_params
    params.require(:sitter_service).permit(:pet_id, :start_date, :end_date, :total_rate, :description)
  end
end
