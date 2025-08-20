json.extract! profile, :id, :user_id, :name, :avatar, :bio, :created_at, :updated_at
json.url profile_url(profile, format: :json)
json.avatar url_for(profile.avatar)
