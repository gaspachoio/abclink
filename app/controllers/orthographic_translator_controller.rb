class OrthographicTranslatorController < ActionController::Base
  layout 'application'

  def translate
    @teksto = params[:teksto].nil? ? '' : params[:teksto]
    @resultado = ''
    @target = params[:target]

    return if @teksto.empty?

    @resultado = OrthographicTranslatorService.new.call(
      @teksto,
      @target
    )
  end
end
