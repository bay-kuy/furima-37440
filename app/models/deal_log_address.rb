class DealLogAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :numbers, :building, :telephone_number, :token

  with_options presence: true do
    validates :user_id, :item_id, :city, :numbers, :token
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
    validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: "10桁もしくは11桁の半角数字を使用してください" }
  end

  def save
    deal_log = DealLog.create(user_id: user_id, item_id: item_id)
    Address.create(postcode: postcode, prefecture_id: prefecture_id, city: city, numbers: numbers, building: building, telephone_number: telephone_number, deal_log_id: deal_log.id)
  end
end