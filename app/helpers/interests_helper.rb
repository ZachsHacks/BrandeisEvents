module InterestsHelper

    def tag_button_color(tag)
      if current_user.interests.pluck(:tag_id).include?(tag.id)
        'btn btn-primary'
      else
        'btn btn-default'
      end
    end

end
