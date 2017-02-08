json.extract! user, :id, :first_name, :last_name, :password_hash, :email, :bio, :is_host, :created_at, :updated_at
json.url user_url(user, format: :json)