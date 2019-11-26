json.extract! reply, :id, :body, :created_at, :updated_at
json.url reply_url(reply, format: :json)
