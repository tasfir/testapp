json.extract! party, :id, :division_id, :district_id, :thana_id, :name, :proprietor, :address, :phone,
              :email, :website, :opening_balance, :remarks, :status, :created_at, :updated_at
json.url party_url(party, format: :json)
