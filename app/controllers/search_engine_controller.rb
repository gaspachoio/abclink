class SearchEngineController < ActionController::Base
  layout 'application'

  def search
    @search_data = nil
    @q = params[:q].nil? ? '' : params[:q]
    @unikamente_pap = params[:unikamente_pap].nil? ? '[esaki OR aki OR esei]' : params[:unikamente_pap]
    @no_spano = params[:no_spano].nil? ? '-la -los -las' : params[:no_spano]

    if !@q.empty?
      @search_data = SearchService.new.call(
        @q,
        params[:start].nil? ? 1 : params[:start].to_i,
        "#{@unikamente_pap} #{@no_spano}"
      )
    end
  end
end
