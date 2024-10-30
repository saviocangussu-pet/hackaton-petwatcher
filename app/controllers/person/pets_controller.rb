class Person::PetsController < ApplicationController
  before_action :authenticate_person!
  before_action :set_person
  before_action :set_pet, only: %i[show edit update destroy]

  def index
    @pets = @person.pets.includes(:specie)
  end

  def show; end

  def new
    @pet = @person.pets.build
    @species = Specie.all
  end

  def create
    @pet = @person.pets.build(pet_params)

    if @pet.save
      redirect_to pets_path, notice: 'Pet was successfully created.'
    else
      flash.now[:alert] = 'There was an error creating the pet. Please check the form and try again.'
      render :new
    end
  end

  def edit
    @species = Specie.all
  end

  def update
    if @pet.update(pet_params)
      redirect_to pet_path(@pet), notice: 'Pet was successfully updated.'
    else
      @species = Specie.all
      flash.now[:alert] = 'There was an error updating the pet. Please check the form and try again.'
      render :edit
    end
  end

  def destroy
    @pet.destroy
    redirect_to pets_path(@person), notice: 'Pet was successfully destroyed.'
  end

  private

  def set_person
    @person = current_person
  end

  def set_pet
    @pet = @person.pets.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :specie_id, :image, :description)
  end
end
