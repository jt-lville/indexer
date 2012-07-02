module MessagesHelper

  def num_unread_messages(user)

    count = 0
    user.received_messages.each do |m|
      if m.unread
        count += 1
      end

    end

    return count

  end

  def render_unread_count(user)

    count = num_unread_messages(user)
    if count == 0
      return ""
    else
      return "(" + count.to_s + ")"
    end

  end
  
end