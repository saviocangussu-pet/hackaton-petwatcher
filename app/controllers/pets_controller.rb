class PetsController < ApplicationController
  before_action :authenticate_person!
  before_action :set_pet, only: [:show, :edit, :update, :destroy]

  def index
    @pets = Pet.includes(:owner, :specie).all
  end

  def show
  end

  def new
    @pet = Pet.new
    @owners = Person.all
    @species = Specie.all
  end

  def create
    @pet = Pet.new(pet_params)

    if @pet.save
      redirect_to @pet, notice: 'Pet was successfully created.'
    else
      @owners = Person.all
      @species = Specie.all
      render :new
    end
  end

  def edit
    @owners = Person.all
    @species = Specie.all
  end

  def update
    if @pet.update(pet_params)
      redirect_to @pet, notice: 'Pet was successfully updated.'
    else
      @owners = Person.all
      @species = Specie.all
      render :edit
    end
  end

  def destroy
    @pet.destroy
    redirect_to pets_path, notice: 'Pet was successfully destroyed.'
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :specie_id, :person_id)
  end
end
