class SearchEngineController < ActionController::Base
  layout 'application'

  def search
    @q = ''
    @start = 1
    @q = params[:q] unless params[:q].nil?
    @start = params[:start].to_i unless params[:start].nil?

    unless @q.empty?
      words = @q.split

      @q_with_variants = ''
      words.each_with_index do |word, index|
        @q_with_variants += "[#{Variant::get_all_variants_by(word)}] "
      end
      @q_with_variants += '[esaki OR aki OR esei] -la -los -las'

      search = Google::Apis::CustomsearchV1
      search_client = search::CustomsearchService.new
      search_client.key = ENV["GOOGLE_SEARCH_CLIENT_KEY"]

      @results = search_client.list_cses(@q_with_variants, {cx: ENV["GOOGLE_SEARCH_CLIENT_CX"], start: @start})

    else
      @results = nil
    end

  end
end
