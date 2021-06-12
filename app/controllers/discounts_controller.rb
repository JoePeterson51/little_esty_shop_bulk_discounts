class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
    @holidays = GetHolidays.new('US').closest_holidays
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    discount = @merchant.discounts.new(discount_params)
    if discount.save
      redirect_to "/merchant/#{@merchant.id}/discounts"
    else
      flash[:alert] = "Must fill out all fields"
      render :new
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    Discount.find(params[:id]).destroy
    redirect_to "/merchant/#{merchant.id}/discounts"
  end

private
  def discount_params
    params.permit(:percentage, :quantity_required)
  end
end