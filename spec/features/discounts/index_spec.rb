require 'rails_helper'

RSpec.describe 'discounts index' do
  before :each do
    @merchant = Merchant.create!(name: 'Hair Care')
    @discount_1 = @merchant.discounts.create!(percentage: 20, quantity_required: 10)
    @discount_2 = @merchant.discounts.create!(percentage: 25, quantity_required: 15)
  end

  it 'shows the discounts and their information' do
    visit "merchant/#{@merchant.id}/discounts"

    save_and_open_page
    within '#merchant-discounts' do
      expect(page).to have_content("20%")
      expect(page).to have_content("10 Items required for discount")
      expect(page).to have_content("25%")
      expect(page).to have_content("15 Items required for discount")
    end
  end
end