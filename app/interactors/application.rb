class Application
  include Interactor

  def error(message)
    context.fail!(message)
  end
end
