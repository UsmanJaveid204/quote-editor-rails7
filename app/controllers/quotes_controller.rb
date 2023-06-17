class QuotesController < ApplicationController
  before_action :set_quote, except: %i[index]

  def index
    @quotes = current_company.quotes.ordered
  end

  def new; end

  def create
    result = ::CreateQuote.call(quote_params: quote_params)

    if result.success?
      respond_to do |format|
        format.html { redirect_to quotes_path notice: "Quote created successfully" }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
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

    respond_to do |format|
      format.html do
        redirect_to_back notice: "Quote was successfully destroyed." if result.success?
        redirect_to_back notice: "Quote was not successfully destroyed." unless result.success?
      end
      format.turbo_stream
    end
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
