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

end
