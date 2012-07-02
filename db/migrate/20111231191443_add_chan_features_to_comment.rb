class AddChanFeaturesToComment < ActiveRecord::Migration
  def self.up

    #add_column :comments, :alias, :string #that good feel when i had already added aliases earlier
    #add_column :comments, :is_anonymous, :boolean
    add_column :comments, :is_saged, :boolean

  end

  def self.down

    #remove_column :comments, :alias
    #remove_column :comments, :is_anonymous
    remove_column :comments, :is_saged
    
  end
end
