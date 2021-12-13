json.extract! user, :id, :username, :password, :credit, :created_at, :updated_at
json.url user_url(user, format: :json)
