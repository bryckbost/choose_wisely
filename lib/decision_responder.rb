require "flash_responder"

class DecisionResponder < ActionController::Responder
  include FlashResponder

  def default_action
    put? ? :show : super
  end
end
