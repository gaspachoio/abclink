require 'csv'

namespace :import do
  desc "Importá palabranan I su variantenan"
  task words: :environment do |t, args|
    file = File.join Rails.root, ENV['FILENAME']
    counter = 0
    CSV.foreach(file, headers: true) do |row|

      variant = Variant.find_by(lexeme: row["pap_cw"])

      unless variant
        word = Word.create(name: row["pap_cw"])
        word.variants.create(lexeme: row["pap_cw"], orthographic_type: 'cw')
        word.variants.create(lexeme: row["pap_aw"], orthographic_type: 'aw') if row["pap_aw"] != 'x'
        counter += 1
      end

    end

    puts "#{counter} palabra a wòrdu importá"
  end

end
