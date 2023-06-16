class QuotesController < ApplicationController
  before_action :set_quote, except: %i[index]

  def index
    @quotes = Quotes.all  
  end

  def new; end

  def create
    result = CreateQuote.call quotes_params: quote_params

    if result.success?
      flash[:notice] = "Quote created successfully"
      redirect_to quotes_path
    else
      flash[:error] = result.error
      redirect_to_back
    end
  end

  def edit; end

  def update
    result = UpdateQuote.call(
      quote: @quote,
      quotes_params: quote_params
    )

    if result.success?
      flash[:notice] = "Quote updated successfully"
      redirect_to quotes_path
    else
      flash[:error] = result.error
      redirect_to_back
    end
  end

  def destroy
    result = DeleteQuote.call(quote: @quote)

    if result.success?
      flash[:notice] = "Deleted"
    else
      flash[:error] = result.error
    end

    redirect_to_back
  end

  private

  def set_quote
    @quote = Quotes.find_by(id: params[:id])
    @quote ||= Quotes.new
  end

  def quotes_params
    params.require(:quote).permit(:name)
  end
end
