class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  has_attached_file :file, :styles => { :medium => "200x200#", :thumb => "100x100#" },
    :default_url => "/images/:style/missing.png",
      :storage => :s3,
      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
      :bucket => 'sschan'
    
  #nesting, experimental vvv
#
 # has_many :comments
  #belongs_to :comments
  
  #acts_as_nested_set
 # accepts_nested_attributes_for :comments
  
  #acts_as_rateable #This is for voting
	
	#comment_regex = /\A[a-zA-Z.\:\;, \/\'\"\(\)\{\}\[\]]+\z/
	
	
	validates :content, :length => {:within => 0..2000}#,
	                     #:format => {:with => comment_regex}
                       
 #attr_accessible :points_up, :points_down
  

end