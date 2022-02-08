class VisitsController < ApplicationController
  def index
    StatsService.new.call

    @visits = Visit.order(visit_at: :desc)

    render json: @visits
  end
end
