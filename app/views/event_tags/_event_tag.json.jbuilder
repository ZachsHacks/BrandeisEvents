json.extract! event_tag, :id, :event_id, :tag_id, :created_at, :updated_at
json.url event_tag_url(event_tag, format: :json)