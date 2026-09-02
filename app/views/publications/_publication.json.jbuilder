json.extract! publication, :id, :name, :address, :opening_balance, :status, :created_at, :updated_at
json.url publication_url(publication, format: :json)
