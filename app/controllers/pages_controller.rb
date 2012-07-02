class PagesController < ApplicationController
	before_filter :authenticate_user!, :except => 'About'
	
	layout :layout_by_resource
  def layout_by_resource
    if signed_in?
      'application'
		else
			'beta'
    end
  end
  
  def About
    @title = "About Us"
  end

  def Contact
    @title = "Contact Us"
		
		@name = 'Default'
		@email = 'example@example.com'
		@content = 'SSC is great!'
  end

  def Privacy
    @title = "Privacy Agreement"
  end

  def Terms
    @title = "Terms of Use"
  end
  def Help
    @title = "Help"
  end
  def Command
    @title = "Command Center"
  end
  def FAQ
      @title = "FAQ"
  end
        
	
end