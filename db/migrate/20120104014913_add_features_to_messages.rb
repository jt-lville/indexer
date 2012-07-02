class AddFeaturesToMessages < ActiveRecord::Migration
  def self.up

    add_column :messages, :unread, :boolean, :default => :true
    add_column :messages, :important, :boolean, :default => :false
    add_column :messages, :group_id, :integer
  end

  def self.down

    remove_column :messages, :unread
    remove_column :messages, :important
    remove_column :messages, :group_id
  end
end
