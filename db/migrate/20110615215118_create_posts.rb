class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|

      #experimental
#      t.integer :parent_id
#      t.integer :lft
#      t.integer :rgt
      #experimental

      t.string :name
      t.string :title
      t.text :content
      t.integer :post_id
      t.references :user

      t.string :user_location
      t.string :post_location
      t.string :source

      t.integer :pageviews

      t.integer :accuracy #upvotes
      t.integer :inaccuracy #downvotes
      t.integer :total_votes
      
      #t.decimal :accuracy_ratio
      #t.decimal :accuracy_percent
		
      t.decimal :trending_value #note: changed to dec

      # Jon's code incoming
      t.decimal :karma
      t.integer :time_effective #Relevant to trending value algo
      
      t.boolean :is_anonymous
      t.string :alias
			
      t.timestamps
    end
		add_index :posts, :user_id
  end

  def self.down
    drop_table :posts
  end
end
