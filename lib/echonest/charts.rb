module Echonest
  class Charts < Base
    
    # Returns an Array of Echonest::Artist objects.
    #
    # ====options:
    #   * rows - results limit, <= 1000.  Defaults to 15.
    #
    def self.get_top_hottt_artists(options = {})
      artists = []
      response = self.request_and_parse("get_top_hottt_artists", true, options)
      response.search("artist").each { |artist_xml| artists << Echonest::Artist.build(artist_xml) }
      artists
    end
      
  end
end