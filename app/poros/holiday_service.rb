class HolidayService
  def self.holidays(country_code)
    response = Faraday.get "https://date.nager.at/api/v2/NextPublicHolidays/#{country_code}"
    body = response.body
    JSON.parse(body, symbolize_names: true)
  end
end