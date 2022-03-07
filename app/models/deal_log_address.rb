class DealLogAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :numbers, :building, :telephone_number

  with_options presence: true do
    validates :user_id, :item_id, :city, :numbers
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
    validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: "10桁もしくは11桁の半角数字を使用してください" }
  end
end