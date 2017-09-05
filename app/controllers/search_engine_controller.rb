class SearchEngineController < ActionController::Base
  layout 'application'

  def search
    @q = ''
    @q = params[:q] unless params[:q].nil?

    unless @q.empty?
      words = @q.split

      @q_with_variants = ''
      words.each do |word|
        @q_with_variants += "[#{Variant::get_all_variants_by(word)}]"
      end
      @q_with_variants += '[esaki OR aki OR esei] -la -los -las'

      search = Google::Apis::CustomsearchV1
      search_client = search::CustomsearchService.new
      search_client.key = ENV["GOOGLE_SEARCH_CLIENT_KEY"]

      @results = search_client.list_cses(@q_with_variants, {cx: ENV["GOOGLE_SEARCH_CLIENT_CX"]})

    else
      @results = nil
    end

  end
end
