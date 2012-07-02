 module PagesHelper
  #Return the Correct Title
  def title
    base_title = "sschan"
    #if @title.nil?
     # base_title
    #else
     # "#{base_title} | #{@title}"
    #end
  end

  def news_line(line_num)

   counter = 1
   file = File.new("newslog.txt", "r")
   while (line = file.gets)

      if counter == line_num

        file.close
        return line

      end
      
      counter = counter + 1
      
  end
  file.close

  end

  def current_version_text

   counter = 1
   file = File.new("versionlog.txt", "r")
   while (line = file.gets)

      if counter == 1
        file.close
        return line
      end

      counter = counter + 1
      
  end
  file.close

  end

  def random_frontpage_yt_url

    yt_links = ["http://www.youtube.com/embed/IdHTnpgpLDc", "http://www.youtube.com/embed/HNrwhRkB_O4",
                "http://www.youtube.com/embed/nUQ1Y8nPz0Q", "http://www.youtube.com/embed/GlVwxSfaYhs", #original 4
                "http://www.youtube.com/embed/2R677MV--WI", "http://www.youtube.com/embed/bxzTrWUajZg",
                "http://www.youtube.com/embed/6-uMkAWj28o", "http://www.youtube.com/embed/TjkSyQHQddo",
                "http://www.youtube.com/embed/4dGJKh9hLTs", "http://www.youtube.com/embed/4wsNJ9K9ROw",
                "http://www.youtube.com/embed/gCCbIkCcRKk", "http://www.youtube.com/embed/KckGp2Hz9yU",
                "http://www.youtube.com/embed/4p8cH380Mrg", "http://www.youtube.com/embed/qeIqZWfVZqY", # layton battle, vow
                "http://www.youtube.com/embed/aG6OxCmWwtM", "http://www.youtube.com/embed/9PCEp8z7FNg" #romeo cinderella, nightmare
                ]

    return yt_links[rand(yt_links.size)]

  end

  def random_lily_url

    str = "lily/lily"

    r_num = rand(5) + 1

    str+= r_num.to_s + ".png"

  end

  def random_banner_url

    str = "banners/banner"
    r_num = rand(9) + 1

    str += r_num.to_s + ".png" #choose banners in the form 'bannerX.png'

    return str

  end

  def random_phrase

    r_num = rand(17)
    str = ""

    if r_num == 0
      str = "C'mon Simon! Use your fighting spirit!"
    elsif r_num == 1
      str = "I'm not going there to die. I'm going to see if I'm really alive. "
    elsif r_num == 2
      str = "Do you know where hell is...? It's in your mind."
    elsif r_num == 3
      str = "Your drill is the drill that's gonna bust straight through heaven and earth and even tomorrow!"
    elsif r_num == 4
      str = "Good news, everyone!"
    elsif r_num == 5
      str = "Soup's on, everypony!"
    elsif r_num == 6
      str = "Musn't run away...Musn't run away..."
    elsif r_num == 7
      str = "Courage is that magic that turns dreams into reality."
    elsif r_num ==8
      str = "Objection!"
    elsif r_num == 9
      str = "A gentleman never leaves a puzzle unsolved."
    elsif r_num == 10
      str = "Just who the hell do you think I am?!"
    elsif r_num == 11
      str = "Take this!! My love! my anger! and all of my sorrow!"
    elsif r_num == 12
      str = "Don't you think dreams and the Internet are similar? They are both areas where the repressed conscious mind vents."
    elsif r_num == 13
      str = "This is a foolish place to be... to inquire about the master of this dream."
    elsif r_num == 14
      str = "We can forget happy things. We can probably forget sad things too. People have the power to forget."
    elsif r_num == 15
      str = "The people would restart their lives in a simple, peaceful village, in the kind of place they wished they had grown up in."
    else
      str = "Elements of Harmony...I know I've heard that from somewhere."
    end

    return str

  end

end
