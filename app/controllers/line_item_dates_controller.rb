# frozen_string_literal: true

class LineItemDatesController < ApplicationController
  before_action :set_quote
  before_action :set_line_item_date, only: %i[edit update destroy]

  def new
    @line_item_date = @quote.line_item_dates.build
  end

  def edit; end

  def create
    @line_item_date = @quote.line_item_dates.create(line_item_date_params)
    render_with(@line_item_date, quote_path(@quote)) do
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @line_item_date.update(line_item_date_params)
    render_with(@line_item_date, quote_path(@quote)) do
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @line_item_date.destroy
    render_with(@line_item_date, quote_path(@quote))
  end

  private

  def line_item_date_params
    params.require(:line_item_date).permit(:date)
  end

  def set_line_item_date
    @line_item_date = @quote.line_item_dates.find(params[:id])
  end

  def set_quote
    @quote = current_company.quotes.find(params[:quote_id])
  end
end
