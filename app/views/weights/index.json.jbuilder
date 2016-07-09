json.array!(@weights) do |weight|
  json.extract! weight, :id, :user_id, :value, :date
  json.url weight_url(weight, format: :json)
end
