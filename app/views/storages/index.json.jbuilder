json.array!(@storages) do |storage|
  json.extract! storage, :id, :user, :file
  json.url storage_url(storage, format: :json)
end
