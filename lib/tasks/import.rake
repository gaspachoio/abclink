require 'csv'

namespace :import do
  desc "Importá palabranan I su variantenan"
  task words: :environment do |t, args|
    # Adding 'aw' variants and setting the universal ones 'pap'
    aw_variants_file = File.join Rails.root, 'stuff/aw_variants.csv'
    counter = 0
    File.open(aw_variants_file, 'r').each_line do |line|
      line = line.strip
      cw_lemma, aw_lemma = line.split ','
      # Go to the next row if Aruba variant is empty
      next if aw_lemma == 'x'

      # Search the Curacao variant in the databaase
      variants = Variant.where(lexeme: cw_lemma).to_a

      # If the cw variant does not exits
      # we create it
      if variants.empty?
        word = Word.create(name: cw_lemma)
        variants << word.variants.create(
          lexeme: cw_lemma,
          orthographic_type: 'cw'
        )
        counter += 1
      end

      variants.each do |variant|
        if variant.lexeme == aw_lemma
          # If the variants are equal, set the existing one as "pap"
          # "pap" means universal across papiamentu orthographies
          variant.orthographic_type = 'pap'
          variant.save
        elsif Variant.where(lexeme: aw_lemma, word_id: variant.word.id).empty?
          # If the variants are different and
          # it is not already in the database attached
          # with th cw variant in this loop iteration
          # then, create the new one with Aruba orthography
          variant.word.variants.create(
            lexeme: aw_lemma,
            orthographic_type: 'aw'
          )
          counter += 1
        end
      end
    end
    puts "#{counter} palabra a wòrdu importá"
  end

end
