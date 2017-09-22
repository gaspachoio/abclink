class SearchEngineController < ActionController::Base
  layout 'application'

  def search
    @q = ''
    @unikamente_pap = '[esaki OR aki OR esei]'
    @no_spano = '-la -los -las'
    @start = 1
    @q = params[:q] unless params[:q].nil?
    @unikamente_pap = params[:unikamente_pap] unless params[:unikamente_pap].nil?
    @no_spano = params[:no_spano] unless params[:no_spano].nil?
    @start = params[:start].to_i unless params[:start].nil?

    unless @q.empty?
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

    else
      @results = nil
    end

  end
end
