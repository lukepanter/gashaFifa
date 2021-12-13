json.extract! transaction, :id, :dateTime, :seller_id, :buyer_id, :item_id, :price, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
