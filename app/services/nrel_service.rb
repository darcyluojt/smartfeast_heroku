class NrelService
  include HTTParty
  base_uri 'https://api.nal.usda.gov/fdc/v1'

  def initialize
    @api_key = ENV['NREL_API_KEY']
  end

  def search_food(query)
    options = {
      query: {
        api_key: @api_key,
        query: query
      }
    }

    self.class.get('/foods/search', options)
  end


end
