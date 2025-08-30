json.extract! group_member, :id, :user_id, :group_id, :created_at, :updated_at
json.url group_member_url(group_member, format: :json)
