class PersonController < ApplicationController
  before_action :authenticate_person!

  def show
    @person = current_person
  end

  def edit
    @person = current_person
  end

  def update
    @person = current_person
    if @person.update(person_params)
      redirect_to @person, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def person_params
    params.require(:person).permit(:name, :phone, :sitter)
  end
end
