class HomeController < ApplicationController
  before_action :authenticate_person!
  before_action :configure_person

  def dashboard
    #Todo: we need to improve this query, i receive only 1 with 0 kms away, when we have 2 users with 0km away
    @closest_sitters = @person.closest_sitters
                              .includes(sitter_profile: :species)
                              .sort_by { |sitter| [sitter.distance, sitter.id] }
                              .last(6)
    @sitters = @person.closest_sitters.includes(sitter_profile: :species)
  end
end
