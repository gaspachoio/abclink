class SearchService < BaseService
  def call(query, start = 1, options = '')
    search_data = {}

    search_data[:query] = query
    search_data[:start] = start

    # PapiamentuVariantsService Adds query_with_variants
    # and words_with_variants to search_data
    search_data.merge!(PapiamentuVariantsService.new.call(query))

    search_data[:query_with_variants] += " #{options}"

    search = Google::Apis::CustomsearchV1
    search_client = search::CustomsearchService.new
    search_client.key = ENV["GOOGLE_SEARCH_CLIENT_KEY"]

    search_data[:results] = search_client.list_cses(search_data[:query_with_variants], {
      cx: ENV["GOOGLE_SEARCH_CLIENT_CX"],
      start: start
    })

    search_data
  end
end
