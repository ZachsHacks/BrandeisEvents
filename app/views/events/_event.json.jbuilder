json.extract! event, :id, :name, :description, :location, :start, :end, :price, :host_id, :created_at, :updated_at
json.url event_url(event, format: :json)