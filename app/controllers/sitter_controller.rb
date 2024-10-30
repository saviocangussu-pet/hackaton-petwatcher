class SitterController < ApplicationController
  before_action :authenticate_person!
  before_action :set_sitter

  private

  def set_sitter
    @sitter = Person.sitters.find(params[:id])
  end
end
