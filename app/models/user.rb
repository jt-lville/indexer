#require 'gravtastic'
class User < ActiveRecord::Base

#  include Gravtastic
#  is_gravtastic!

  has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "100x100>" }, 
    :default_url => "/images/medium/missing_av.png", #avatars
      :storage => :s3,
      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
      :bucket => 'sschan'

  #acts_as_taggable #this is for user tag browsing
  validate :check_beta_code, :on => 'create'
	
	has_and_belongs_to_many :roles
	has_many :comments
	
  has_many :received_messages, :class_name => 'Message', :foreign_key => :recipient_id
  
  has_many :preferences
	
	has_many :posts, :dependent => :destroy
	
	def role?(role)
    self.role.to_sym == role.to_sym
  end
	  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
	attr_accessor :beta_code
  attr_accessible :beta_code, :email, :name, :password, :password_confirmation, :remember_me,
    :feed_preference, :karma
	
	name_regex = /\A[a-zA-Z .-]+\z/
	
	validates :name, :presence=> true,
									 :length => {:within => 2..45},
									 :format => {:with => name_regex }
	
	validates :password, :presence => true

  #POSSIBLE_SERVICES = ['Gravatar', 'Facebook', 'Twitter', 'Google']
	
	def check_beta_code
		beta_code_array = ['overlord']
		
		unless beta_code_array.include?(beta_code)
			errors.add(:beta_code, "Invalid Super Secret Id")
		end
	end
	
	
end
