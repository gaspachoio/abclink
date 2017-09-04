class InlineFormsCreateWords < ActiveRecord::Migration

  def self.up
    #create_table :words, :id => true do |t|
    create_table :words do |t|
      t.string :name 
      t.text :description 
      t.string :pos 
      t.timestamps
    end
  end

  def self.down
    drop_table :words
  end

end
