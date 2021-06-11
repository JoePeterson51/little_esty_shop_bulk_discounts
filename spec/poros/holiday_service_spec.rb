require 'rails_helper'

RSpec.describe HolidayService do
  describe '#closest_holidays' do
    it 'returns the 3 closest holidays to todays date' do
      mock_response =
      (
      [{:date=>"2021-11-11", :localName=>"Veterans Day", :name=>"Veterans Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>nil, :type=>"Public"},
      {:date=>"2021-11-25", :localName=>"Thanksgiving Day", :name=>"Thanksgiving Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>1863, :type=>"Public"},
      {:date=>"2021-12-24", :localName=>"Christmas Day", :name=>"Christmas Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>nil, :type=>"Public"},
      {:date=>"2021-12-31", :localName=>"New Year's Day", :name=>"New Year's Day", :countryCode=>"US", :fixed=>false, :global=>true, :counties=>nil, :launchYear=>nil, :type=>"Public"}]
      )

      allow(HolidayService).to receive(:holidays).and_return(mock_response)
      json = HolidayService.holidays('US')

      expect(json).to be_a(Array)
      expect(json[0]).to have_key(:date)
      expect(json[0]).to have_key(:localName)
      expect(json[0]).to have_key(:name)
      expect(json[0]).to have_key(:countryCode)
    end
  end
end