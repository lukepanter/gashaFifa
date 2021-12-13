class Banner < ApplicationRecord
	has_many :likes
	has_many :banner_items
	def get_rate
		allItem = self.banner_items
		allName = Array.new 
		allItem.each do |itemID|
			item = Item.find_by(id: itemID.item_id)
			if allName.size == 0
				allName.push(item.itemname)
			elsif !(allName.include? item.itemname)
				allName.push(item.itemname)
			end
		end		
		return allName
	end

	def random_one(user_id)
		allItem = self.banner_items
		chooseItem = allItem.sample
		if chooseItem != nil
			item = Inventory.create(user_id: user_id, item_id: chooseItem.item_id,price: 0,status:"not for sell")
			item.save
			item = Item.find_by(id: chooseItem.item_id)
			chooseItem.destroy
			box = Array.new
			box.push(item.itemname)
			box.push(item.rarity)
			box.push(item.img_url)
			return box
		end
	end

	def five_random(user_id)
		allItem = self.banner_items
		chooseItems = allItem.sample(5)
		boxes = Array.new
		chooseItems.each do |chooseItem|
			item = Inventory.create(user_id: user_id, item_id: chooseItem.item_id,price: 0,status:"not for sell")
			item.save
			item = Item.find_by(id: chooseItem.item_id)
			chooseItem.destroy
			box = Array.new
			box.push(item.itemname)
			box.push(item.rarity)
			box.push(item.img_url)
			boxes.push(box)
		end
		return boxes
	end

end
