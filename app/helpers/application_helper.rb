module ApplicationHelper

    def gravatar_for(user, options = {size: 80})
        size = options[:size]
        email_address = user.email.downcase
        hash = Digest::MD5.hexdigest(email_address)
        gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
        image_tag(gravatar_url, alt: user.username, class: "rounded shadow")
    end
    
end

