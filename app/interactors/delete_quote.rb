class DeleteQuote < ApplicationInteractor
  delegate :quote, to: :context

  def call
    return if quote.destroy

    error quote.errors.full_messages.to_sentence
  end
end
