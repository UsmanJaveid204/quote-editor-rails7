class QuotesController < ApplicationController
  before_action :set_quote, except: %i[index]

  def index
    @quotes = Quote.all  
  end

  def new; end

  def create
    result = ::CreateQuote.call(quote_params: quote_params)

    if result.success?
      flash[:notice] = "Quote created successfully"
      redirect_to quotes_path
    else
      flash[:error] = result.error
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    result = UpdateQuote.call(
      quote: @quote,
      quote_params: quote_params
    )

    if result.success?
      flash[:notice] = "Quote updated successfully"
      redirect_to quotes_path
    else
      flash[:error] = result.error
      render :edit, status: :unprocessable_entity
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
    @quote = Quote.find_by(id: params[:id])
    @quote ||= Quote.new
  end

  def quote_params
    params.require(:quote).permit(:name)
  end
end
