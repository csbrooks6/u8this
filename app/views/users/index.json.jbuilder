json.array!(@users) do |user|
  json.extract! user, :id, :username, :email, :daily_calorie_goal
  json.url user_url(user, format: :json)
end
