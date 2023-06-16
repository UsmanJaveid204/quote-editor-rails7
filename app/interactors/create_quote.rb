class CreateQuote < ApplicationInteractor
  delegate :quote, :quote_params, to: :context

  def call
    context.quote = Quote.new quote_params
    return if quote.save

    error quote.errors.full_messages.to_sentence
  end
end
