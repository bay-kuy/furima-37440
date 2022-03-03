class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  ## Activehashとのアソシエーション
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :ship_date
  ## 以上

  has_one_attached :image
  belongs_to :user

  validates :image, :name, :description, presence: true
  validates :category_id, :condition_id, :postage_id, :prefecture_id,:ship_date_id, numericality: { message: "can't be blank"}
  with_options  presence: true, format: { with: /\A[0-9]+\z/ } do
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                      presence: { message: "can't be blank" }
  end
end
