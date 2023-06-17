class CreateQuote < ApplicationInteractor
  delegate :quote, :quote_params, :current_company, to: :context

  def call
    context.quote = current_company.quote.new quote_params
    return if quote.save

    error quote.errors.full_messages.to_sentence
  end
end
