class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :name
      t.text :content
#
#experimental:
#      t.integer :parent_id
#      t.integer :lft
#      t.integer :rgt
      
      t.references :post
      t.references :user

      t.integer :points_up
      t.integer :points_down
      
      t.decimal :confidence_value
      t.decimal :relative_value #trending value for comments
      
      t.decimal :karma
      t.integer :time_effective
      
      t.boolean :is_anonymous
      t.string :alias

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
