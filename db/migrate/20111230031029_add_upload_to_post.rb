class AddUploadToPost < ActiveRecord::Migration
  def self.up
#    change_table :posts do |t|
#      t.has_attached_file :upload
#
#    end
    
    add_column :posts, :upload_file_name, :string
    add_column :posts, :upload_content_type, :string
    add_column :posts, :upload_file_size, :integer
    add_column :posts, :upload_updated_at, :datetime
  end

  def self.down
#    drop_attached_file :posts, :upload

    remove_column :posts, :upload_file_name
    remove_column :posts, :upload_content_type
    remove_column :posts, :upload_file_size
    remove_column :posts, :upload_updated_at

  end
end
