require 'rails_helper'

RSpec.describe 'discounts index' do
  before :each do
    @merchant = Merchant.create!(name: 'Hair Care')
    @discount_1 = @merchant.discounts.create!(percentage: 20, quantity_required: 10)
    @discount_2 = @merchant.discounts.create!(percentage: 25, quantity_required: 15)
  end

  it 'shows the discounts and their information' do
    visit "merchant/#{@merchant.id}/discounts"

    within '#merchant-discounts' do
      expect(page).to have_content("20%")
      expect(page).to have_content("10 Items required for discount")
      expect(page).to have_content("25%")
      expect(page).to have_content("15 Items required for discount")
    end
  end

  it 'shows the next 3 upcoming holidays and their dates' do
    mock_holidays = instance_double("GetHolidays", holidays:
      [{:date=>"2021-11-11", :localName=>"Veterans Day", :name=>"Veterans Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>nil, :type=>"Public"},
      {:date=>"2021-11-25", :localName=>"Thanksgiving Day", :name=>"Thanksgiving Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>1863, :type=>"Public"},
      {:date=>"2021-12-24", :localName=>"Christmas Day", :name=>"Christmas Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>nil, :type=>"Public"},
      {:date=>"2021-12-31", :localName=>"New Year's Day", :name=>"New Year's Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>nil, :type=>"Public"}]
    )
    # require 'pry'; binding.pry
  end
end