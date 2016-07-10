json.array!(@values) do |value|
  json.extract! value, :id, :user_id, :weight, :fat, :date
  json.url value_url(value, format: :json)
end
