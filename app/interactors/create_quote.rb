class CreateQuote < ApplicationInteractor
  delegate :quote, :quotes_params, to: :context

  def call
    context.quote = Quote.new quotes_params
    return if quote.save

    error quote.errors.full_messages.to_sentence
  end
end
