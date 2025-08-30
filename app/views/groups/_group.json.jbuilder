json.extract! group, :id, :logo, :title, :description, :created_at, :updated_at
json.url group_url(group, format: :json)
json.logo url_for(group.logo)
