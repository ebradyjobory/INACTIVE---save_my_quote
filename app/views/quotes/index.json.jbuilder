json.array!(@quotes) do |quote|
  json.extract! quote, :name, :content
  json.url quote_url(quote, format: :json)
end
