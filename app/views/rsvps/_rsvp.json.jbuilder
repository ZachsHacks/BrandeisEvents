json.extract! rsvp, :id, :user_id, :event_id, :choice, :created_at, :updated_at
json.url rsvp_url(rsvp, format: :json)