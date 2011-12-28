class DecisionsController < ApplicationController
  respond_to :html

  def show
    @decision = Decision.find_by_token!(params[:id])
    respond_with @decision
  end

  def new
    @decision = Decision.new(request.query_parameters)
    respond_with @decision
  end

  def create
    @decision = Decision.create(params[:decision])
    respond_with @decision
  end
end
