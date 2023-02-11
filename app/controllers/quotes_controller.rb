# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :set_quote, only: %i[show edit update destroy]

  def index
    @quotes = current_company.quotes.ordered
  end

  def show
    @line_item_dates = @quote.line_item_dates.includes(:line_items).ordered
  end

  def new
    @quote = Quote.new
  end

  def edit; end

  def create
    @quote = current_company.quotes.create(quote_params)
    render_with(@quote, quotes_path) do
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @quote.update(quote_params)
    render_with(@quote, quotes_path) do
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quote.destroy
    render_with(@quote, quotes_path)
  end

  private

  def set_quote
    @quote = current_company.quotes.find(params[:id])
  end

  def quote_params
    params.require(:quote).permit(:name)
  end
end
