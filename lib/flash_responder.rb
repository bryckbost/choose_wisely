module FlashResponder
  def navigation_behavior(error)
    if !get? && has_errors?
      request.flash[:alert] = resource.errors.full_messages.join(". ") + "."
    end

    super
  end
end
