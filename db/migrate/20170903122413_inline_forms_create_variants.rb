class InlineFormsCreateVariants < ActiveRecord::Migration

  def self.up
    #create_table :variants, :id => true do |t|
    create_table :variants do |t|
      t.string :lexeme
      t.string :orthographic_type
      t.belongs_to :word
      t.timestamps
    end
  end

  def self.down
    drop_table :variants
  end

end
