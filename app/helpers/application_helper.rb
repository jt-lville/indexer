module ApplicationHelper
  def title
    base_title = "sschan"
    #if @title.nil?
     # base_title
    #else
     # "#{base_title} | #{@title}"
    # end
  end

    def filter_comment(c) #use for both OP's and comments

    c1 = c.content

    str1 = '<n class = "unkfunc">'
    str2 = '</n>'
    str3 = '<a class = "unkfunc" href = "/posts/'
    str4 = '</a>'

    if c1.index("[spoiler]") != nil #auto-finish spoiler tags
      if c1.index("[/spoiler]") == nil
        c1 += "[/spoiler]"
      end
    end

    if c1 != nil
    arr_lines = c1.split("\n") #split the text into lines

    arr_lines.each do |a|
      if a[0] == ">" and a[1] == ">" #link replies
        num = a[2..a.size]
        tmp = num.split(' ')
        num = tmp[0]

        begin
        if Comment.find(num) != nil #link replies
          end

          link = str3 + c.post.id.to_s + "#" + num + '">'
          if a.index(" ") != nil
          a.insert(a.index(" "), str4)
          else
          a << str4
          end
          a.insert(0, link)
          
        rescue #defaults to greentext if no link found
        end
        
      end
        
      if a[0] == ">"
        a.insert(0, str1) #add the greentext tag
        a << str2 #close the greentext tag
        
        #a << "DERP"
      end

      if a.index("http://") != nil
        a.insert(a.index("http://"), ('<a href = "' + a[a.index("http://")..a.size] + '">'))
        a << "</a>"
      elsif a.index("https://") != nil
        a.insert(a.index("https://"), ('<a href = "' + a[a.index("https://")..a.size] + '">'))
        a << "</a>"
      elsif a.index("www.") != nil
        a.insert(a.index("www."), ('<a href = "http://' + a[a.index("www.")..a.size] + '">'))
        a << "</a>"
      end

    end

    c1 = ""

#    arr_lines.each do |a|
#      strtmp = "\n"
#      if arr_lines.index(a) == (arr_lines.size - 1) #recombine the lines into text
#        strtmp = ""
#      end
#      c1 += a + strtmp
#    end

    c2 = arr_lines.join('<br/>')    #recombine the lines into text

    #c2 = c1.gsub("\n", '<br/>').html_safe

    c2 = c2.gsub("eels bad man", "eelings baddingly mans") #troll wordfilters
    c2 = c2.gsub("eels good man", "eelings baddingly mans")
    c2 = c2.gsub("sat froc", "sad frog")

    c2 = c2.gsub("[spoiler]",'<font style="BACKGROUND-COLOR: #000000">').html_safe #possible bug: unclosed spoiler tags still work
    c2 = c2.gsub("[/spoiler]","</font>").html_safe

    c2 = c2.gsub("sade frueg", "sad frog").html_safe

    end

  end
  
  def errorImage(user, field)
    if user.errors.any?
      registrationsErrorImage(user.errors[field].blank?, user, field)
    else
      image_tag('errors_blank.png')
    end
  end
  
  def registrationsErrorImage(is_error)
      if is_error
          image_tag('errors_check.png')
      else
        image_tag('errors_x.png')
      end
  end
end