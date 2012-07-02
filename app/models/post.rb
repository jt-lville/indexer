 class Post < ActiveRecord::Base

  has_attached_file :upload, :styles => { :medium => "200x200#", :thumb => "100x100#" },
    :default_url => "/images/:style/missing.png",
      :storage => :s3,
      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
      :bucket => 'sschan'
      #:path => ":attachment/:id/:style.:extension",

    #:path => "/images/uploads/", :url => "/images/uploads/:style/:post_id.:extension" #uploads

	acts_as_taggable

  is_impressionable ##for viewing

	belongs_to :user

	has_many :comments, :dependent => :destroy
	
	#has_many :votes, :as => :voteable
	#has_many :voting_users,
	#		 :through => :votes,
	#		 :source => :user	

#	validates :name, :presence => true #commented out for experimental reasons: if it fails, uncomment it

	validates :title, :length => {:within => 0..150}#, Jon: removed the title regex
									  #:format => {:with => title_regex }

	validates :content, :length => {:within => 0..2000}
                    
#   validates :post_location, :presence => true                                                                    

#   
#   validates :user_location, :presence => true
#   
#   validates :source, :presence => true

	attr_accessor :politics, :tech, :entertainment, :sports, :science, :crime, :business, :social, :nature, :other
  
	attr_accessible :name, :title, :content, :user_location, :post_location, :user_id,
    :post_id, :karma, :trending_value, :pageviews, :accuracy, :inaccuracy,   # <-- Jon's super code
    :total_votes, :time_effective, :accuracy_ratio, :accuracy_percent, :source, :alias, :upload,

     :upload_file_name, :upload_content_type, :upload_file_size,
                  :upload_updated_at
     
     	
end
