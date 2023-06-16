class UpdateQuote < ApplicationInteractor
  delegate :quote, :quotes_params, to: :context

  def call
    return if quote.update quotes_params

    error quote.errors.full_messages.to_sentence
  end
end
