class Api::ApiController < ActionController::Base
  def palabra
    variant = Variant.find_by(lexeme: params[:lexeme])

    return render json: variant.word.variants if variant
    render json: []
  end
end
