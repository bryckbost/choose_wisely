require "decision_responder"

class DecisionsController < ApplicationController
  self.responder = DecisionResponder
  respond_to :html

  before_filter :load_decision, :only => [:show, :update]

  def show
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

  def update
    @decision.attributes = params[:decision]
    @decision.continue
    respond_with @decision
  end

  private
    def load_decision
      @decision = Decision.find_by_token!(params[:id])
    end
end
