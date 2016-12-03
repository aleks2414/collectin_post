json.extract! post, :id, :title, :description, :date, :category, :paper, :user_id, :favorite, :url, :photo, :created_at, :updated_at
json.url post_url(post, format: :json)