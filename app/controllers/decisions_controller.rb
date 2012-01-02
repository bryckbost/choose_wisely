class DecisionsController < ApplicationController
  respond_to :html

  before_filter :load_decision, :only => [:show, :update]

  def show
    respond
  end

  def new
    @decision = Decision.new(request.query_parameters)
    respond
  end

  def create
    @decision = Decision.create(params[:decision])
    respond
  end

  def update
    @decision.attributes = params[:decision]
    @decision.continue
    respond
  end

  private
    def load_decision
      @decision = Decision.find_by_token!(params[:id])
    end

    def respond
      flash[:alert] = @decision.errors.full_messages.join(". ")
      respond_with @decision
    end
end
