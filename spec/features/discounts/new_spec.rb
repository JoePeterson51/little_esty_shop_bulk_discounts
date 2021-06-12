require 'rails_helper'

RSpec.describe '#new' do
  it 'has a link on the merchants discount index to add a discount' do
    merchant = Merchant.create!(name: 'Hair Care')

    visit "/merchant/#{merchant.id}/discounts"

    within '#merchant-discounts' do
      expect(page).to_not have_content('20%')
      expect(page).to_not have_content('15')
    end

    click_link 'Create New Discount'

    expect(current_path).to eq("/merchant/#{merchant.id}/discounts/new")

    fill_in('Percentage', with: 20)
    fill_in('Quantity required', with: 15)
    click_button "Save"

    within '#merchant-discounts' do
      expect(page).to have_content('20%')
      expect(page).to have_content('15')
    end
  end
end