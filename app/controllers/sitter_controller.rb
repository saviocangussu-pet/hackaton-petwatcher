class SitterController < ApplicationController
  before_action :authenticate_person!
  before_action :set_sitter

  def show
    @build_sitter_service = SitterService.new
  end

  private

  def set_sitter
    @sitter = Person.sitters.find(params[:id])
  end
end
