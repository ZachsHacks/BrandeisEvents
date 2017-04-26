module InterestsHelper

    def tag_button_color(tag)
      if current_user.interests.pluck(:tag_id).include?(tag.id)
        'btn btn-primary btn-interests'
      else
        'btn btn-default btn-interests'
      end
    end

end
