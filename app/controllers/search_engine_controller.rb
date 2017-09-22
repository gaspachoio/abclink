class SearchEngineController < ActionController::Base
  layout 'application'

  def search
    @results = nil
    @q = params[:q].nil? ? '' : params[:q]
    @unikamente_pap = params[:unikamente_pap].nil? ? '[esaki OR aki OR esei]' : params[:unikamente_pap]
    @no_spano = params[:no_spano].nil? ? '-la -los -las' : params[:no_spano]
    @start = params[:start].nil? ? 1 : params[:start].to_i

    return @results if @q.empty?
    
    words = @q.split
    @q_with_variants = ''
    words.each_with_index do |word, index|
      @q_with_variants += "[#{Variant::get_all_variants_by(word)}] "
    end
    @q_with_variants += "#{@unikamente_pap} #{@no_spano}"
    search = Google::Apis::CustomsearchV1
    search_client = search::CustomsearchService.new
    search_client.key = ENV["GOOGLE_SEARCH_CLIENT_KEY"]
    @results = search_client.list_cses(@q_with_variants, {cx: ENV["GOOGLE_SEARCH_CLIENT_CX"], start: @start})
  end
end
