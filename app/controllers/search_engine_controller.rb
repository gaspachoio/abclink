class SearchEngineController < ActionController::Base
  layout 'application'

  def search
    @q = params[:q].nil? ? '' : params[:q]
    @elimina_otro_idioma = params[:elimina_otro_idioma].nil? ? '-la -los -las' : params[:elimina_otro_idioma]
    @search_data = nil

    return if @q.empty?

    @search_data = SearchService.new.call(
      @q,
      params[:start].nil? ? 1 : params[:start].to_i,
      @elimina_otro_idioma
    )
  end
end
