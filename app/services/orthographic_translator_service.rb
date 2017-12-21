class OrthographicTranslatorService < BaseService
  API_PATH = 'https://palabra.papiamentu.info/api/v1/palabra'

  def call(text, target_orthographic)
    words = text.split

    words_in_target_orthographic = []

    words.each do |word|
      words_in_target_orthographic << get_variant(word, target_orthographic)
    end

    words_in_target_orthographic.join(' ')
  end

  def get_variant(word, target_orthographic)
    variant = "#{word}*"

    word.delete!('.(),')

    uri = URI.parse(URI.escape "#{API_PATH}/#{word}")
    response = HTTParty.get(uri)
    data = JSON.parse response.body

    return variant if data['variants'].nil?

    word_is_pap = !(data['variants'].select { |v| v['orthographic_type'] == 'pap' && v['lemma'].downcase == word.downcase }.empty?)

    return word if word_is_pap

    target_orthographic_variants = data['variants'].select { |v| v['orthographic_type'] == target_orthographic }

    if target_orthographic_variants.empty?
      variant
    else
      target_orthographic_variants.first['lemma']
    end
  end
end
