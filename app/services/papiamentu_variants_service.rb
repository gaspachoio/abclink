class PapiamentuVariantsService < BaseService
  API_PATH = 'https://palabra.papiamentu.info/api/v1/palabra'

  def call(query)
    words = query.split

    query_with_variants = ''
    words_with_variants = []

    words.each do |word|
      variants = variants_for(word)
      query_with_variants += "[#{variants.join(' OR ')}]"
      words_with_variants << variants
    end

    {
      query_with_variants: query_with_variants,
      words_with_variants: words_with_variants
    }
  end

  def variants_for(word)
    variants = [word]

    response = HTTParty.get("#{API_PATH}/#{word}")
    data = JSON.parse response.body

    return variants if data['variants'].nil?
    
    data['variants'].each do |variant|
      variants << variant['lemma'] unless variants.include? variant['lemma']
    end
    variants
  end
end
