module PostsHelper
  def join_tags(post)
    post.tags.map { |t| t.name }.join(", ")
  end
  
  def truncate_content(post, content)
    output = content.truncate(250, :omission => '')
    output += link_to('... See More', post, :id=>'omitText') if content.size > 250
    output.html_safe
  end

	def showTags(post)
		tagString = ''
		tagString += "Politics " if post.tag(:politics)
		tagString += "Technology " if post.tag(:technology)
		tagString += "Entertainment " if post.tag(:entertainment)
		tagString += "Sports " if post.tag(:sports)
		tagString += "Science " if post.tag(:science)
		tagString += "Crime " if post.tag(:crime)
		tagString += "Business " if post.tag(:business)
		tagString += "Social " if post.tag(:social)
		tagString += "Nature " if post.tag(:nature)
		tagString += "Other " if post.tag(:other)
		
		return tagString
	end
	
	def flagPost(post)
		flagged = true
	end

    def comments_omit(post)

    list = post.comments

    if post.comments.size>5
      list = post.comments[post.comments.size-5..post.comments.size-1]
    end

    return list

  end

  def comments_omitted_num(post)

    return post.comments.size - comments_omit(post).size

  end

  def image_replies_omitted_message(post)

    numposts = 0
    count = 0

    post.comments.each do |c|
      numposts += 1

      if c.file.url != "/images/original/missing.png" and (comments_omit(post).index(c) == nil)
        count += 1
      end

    end

    if count == 1
      return ("and 1 image reply ")
    elsif count > 1
      return ("and " + count.to_s + " image replies ")
    else
      return ""
    end

  end

	
	def displayIcon(num)
    image_tag("header/icon#{num}.png", :class=>'icon')
  end
  
end