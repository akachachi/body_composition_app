json.array!(@fats) do |fat|
  json.extract! fat, :id, :user_id, :value, :date
  json.url fat_url(fat, format: :json)
end
