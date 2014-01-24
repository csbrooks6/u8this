json.array!(@servings) do |serving|
  json.extract! serving, :id, :user, :day_order, :quantity, :name, :calories, :when_eaten
  json.url serving_url(serving, format: :json)
end
