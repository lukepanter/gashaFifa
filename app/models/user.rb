class User < ApplicationRecord
	has_secure_password
	has_many :likes
	has_many :inventorys
	has_many :sellers, class_name: 'Transaction', foreign_key: 'seller_id'
	has_many :buyers,  class_name: 'Transaction', foreign_key: 'buyer_id'
	def get_banner
  		return listOfBanner = self.likes
	end

	def buyItem(inventory)
		time = Time.zone.now
		seller_id = inventory.user_id
		buyer_id = self.id
		item_id = inventory.item_id
		price = inventory.price
		self.credit -= Float(price)
		User.find_by(id: seller_id).credit += Float(price)
		tran = Transaction.create(dateTime: time, seller_id: seller_id, buyer_id: buyer_id, item_id: item_id, price: price)
		tran.save
		inventory.user_id = self.id
		inventory.status = "not for sale"
		inventory.save
		self.save
	end

	def buyGacha(price)
		self.credit -= price
		self.save
	end
end
