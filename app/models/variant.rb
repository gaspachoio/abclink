class Variant < ActiveRecord::Base
  attr_reader :per_page
  @per_page = 7
  attr_writer :inline_forms_attribute_list
  has_paper_trail

  belongs_to :word

  def _presentation
    "#{lexeme}"
  end


  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :lexeme , "lexeme", :text_field ],
      [ :orthographic_type , "type", :text_field ],
    ]
  end


  def self.not_accessible_through_html?
    true
  end

  def self.order_by_clause
    "lexeme"
  end

  def to_json(options={})
   options[:except] ||= [:id, :word_id, :create_at, :update_at]
   super(options)
 end

 def self.get_all_variants_by(lexeme)
   all_variants = "#{lexeme}"
   variants = []

   variant = self.find_by(lexeme: lexeme)
   variants = variant.word.variants if variant

   if variants.count >= 2
     variants.each do |variant|
       all_variants += " OR #{variant.lexeme}" unless all_variants.include? variant.lexeme
     end
   end

   return all_variants
 end

end
