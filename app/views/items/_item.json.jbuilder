json.extract! item, :id, :itemname, :rarity, :img_url, :created_at, :updated_at
json.url item_url(item, format: :json)
