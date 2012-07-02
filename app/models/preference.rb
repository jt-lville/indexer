class Preference < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :user
  
end
