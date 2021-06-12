require 'rails_helper'

RSpec.describe 'discounts edit' do
  it 'edits the discount' do
    merchant = Merchant.create!(name: 'Hair Care')
    discount_1 = merchant.discounts.create!(percentage: 20, quantity_required: 10)

    visit "/merchant/#{merchant.id}/discounts/#{discount_1.id}"

    within '#discount' do
      expect(page).to have_content("20%")
      expect(page).to have_content("10 Items required for discount")
    end

    click_link "Edit Discount"

    expect(current_path).to eq("/merchant/#{merchant.id}/discounts/#{discount_1.id}/edit")

    fill_in "Percentage", with: 25
    fill_in "Quantity required", with: 15
    click_button "Save"

    within '#discount' do
      expect(page).to have_content("25%")
      expect(page).to have_content("15 Items required for discount")
      expect(page).to_not have_content("20%")
      expect(page).to_not have_content("10 Items required for discount")
    end
  end

  it 'requireds all fields to be filled out' do
    merchant = Merchant.create!(name: 'Hair Care')
    discount_1 = merchant.discounts.create!(percentage: 20, quantity_required: 10)

    visit "/merchant/#{merchant.id}/discounts/#{discount_1.id}/edit"

    fill_in "Percentage", with: ''
    fill_in "Quantity required", with: 15
    click_button "Save"

    expect(page).to have_content('Must fill out all fields')
    expect(current_path).to eq("/merchant/#{merchant.id}/discounts/#{discount_1.id}/edit")
  end
end