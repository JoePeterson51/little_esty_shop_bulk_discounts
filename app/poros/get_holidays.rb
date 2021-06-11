require 'faraday'
require 'json'

class GetHolidays
  attr_reader :holidays

  def initialize(country_code)
    @holidays = HolidayService.holidays(country_code)
  end

  def closest_holidays
    days = @holidays.find_all do |holiday|
      Date.parse(holiday[:date]) >= Date.today
    end[0..2]
  end
end