require 'rails_helper'

RSpec.describe GetHolidays do
  it 'can recieve data' do
    mock_response =
    (
    [{:date=>"2021-11-11", :localName=>"Veterans Day", :name=>"Veterans Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>nil, :type=>"Public"},
    {:date=>"2021-11-25", :localName=>"Thanksgiving Day", :name=>"Thanksgiving Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>1863, :type=>"Public"},
    {:date=>"2021-12-24", :localName=>"Christmas Day", :name=>"Christmas Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>nil, :type=>"Public"},
    {:date=>"2021-12-31", :localName=>"New Year's Day", :name=>"New Year's Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>nil, :type=>"Public"}]
    )

    allow(HolidayService).to receive(:holidays).and_return(mock_response)
    days = GetHolidays.new('US')

    expect(days.holidays).to be_a(Array)
    expect(days.holidays[0][:localName]).to eq("Veterans Day")
  end

  describe '#closest_holidays' do
    it 'can return the 3 closest holidays to todays date' do
      mock_response =
      (
      [{:date=>"2021-11-11", :localName=>"Veterans Day", :name=>"Veterans Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>nil, :type=>"Public"},
      {:date=>"2021-11-25", :localName=>"Thanksgiving Day", :name=>"Thanksgiving Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>1863, :type=>"Public"},
      {:date=>"2999-12-24", :localName=>"Christmas Day", :name=>"Christmas Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>nil, :type=>"Public"},
      {:date=>"2021-12-31", :localName=>"New Year's Day", :name=>"New Year's Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>nil, :type=>"Public"}]
      )

      allow(HolidayService).to receive(:holidays).and_return(mock_response)
      days = GetHolidays.new('US')

      new_years = days.closest_holidays.any? do |holiday|
        holiday[:localName] == "New Year's Day"
      end

      expect(days.closest_holidays[0][:localName]).to eq("Veterans Day")
      expect(days.closest_holidays[0][:date]).to eq("2021-11-11")
      expect(days.closest_holidays[1][:localName]).to eq("Thanksgiving Day")
      expect(days.closest_holidays[1][:date]).to eq("2021-11-25")
      expect(days.closest_holidays[2][:localName]).to eq("Christmas Day")
      expect(days.closest_holidays[2][:date]).to eq("2999-12-24")
      expect(new_years).to eq(false)
    end
  end
end


