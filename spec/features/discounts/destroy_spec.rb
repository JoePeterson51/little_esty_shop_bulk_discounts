require 'rails_helper'

RSpec.describe 'discounts destroy' do
  it 'destroys the discounts' do
    merchant = Merchant.create!(name: 'Hair Care')
    discount_1 = merchant.discounts.create!(percentage: 20, quantity_required: 10)

    visit "/merchant/#{merchant.id}/discounts"

    within '#merchant-discounts' do
      expect(page).to have_content("20%")
      expect(page).to have_content("10 Items required for discount")
    end

    click_link "Delete Discount"

    expect(current_path).to eq("/merchant/#{merchant.id}/discounts")

     within '#merchant-discounts' do
      expect(page).to_not have_content("20%")
      expect(page).to_not have_content("10 Items required for discount")
    end
  end
end