class Item < ApplicationRecord
	has_many :inventorys
	has_many :banner_items
end
