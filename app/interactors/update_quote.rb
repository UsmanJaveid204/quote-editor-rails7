class UpdateQuote < ApplicationInteractor
  delegate :quote, :quote_params, to: :context

  def call
    return if quote.update quote_params

    error quote.errors.full_messages.to_sentence
  end
end
