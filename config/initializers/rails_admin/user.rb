if User.table_exists?
  RailsAdmin.config User do
    list do
      # simply adding fields by their names (order will be maintained)
      include_fields :id, :uid, :first_name, :last_name, :survey_sent, :events, :tags, :created_at, :updated_at, :can_host, :is_admin, :calendar_hash, :rsvps, :interests
    end
  end
end
