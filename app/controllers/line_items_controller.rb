# frozen_string_literal: true

class LineItemsController < ApplicationController
  before_action :set_quote
  before_action :set_line_item_date
  before_action :set_line_item, only: %i[edit update destroy]

  def new
    @line_item = @line_item_date.line_items.build
  end

  def edit; end

  def create
    @line_item = @line_item_date.line_items.create(line_item_params)

    render_with(@line_item, quote_path(@quote)) do
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @line_item.update(line_item_params)
    render_with(@line_item, quote_path(@quote)) do
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @line_item.destroy
    render_with(@line_item, quote_path(@quote))
  end

  private

  def line_item_params
    params.require(:line_item).permit(:name, :description, :quantity, :unit_price)
  end

  def set_quote
    @quote = current_company.quotes.find(params[:quote_id])
  end

  def set_line_item_date
    @line_item_date = @quote.line_item_dates.find(params[:line_item_date_id])
  end

  def set_line_item
    @line_item = @line_item_date.line_items.find(params[:id])
  end
end
