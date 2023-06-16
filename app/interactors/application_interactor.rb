class ApplicationInteractor
  include Interactor

  def error(message)
    context.fail!(error: message)
  end
end
