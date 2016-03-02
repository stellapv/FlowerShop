class Flower < ActiveRecord::Base

	has_and_belongs_to_many :types
	has_many :order_items
  has_many :comments

	has_attached_file :flower_photo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_presence :flower_photo 
	validates_attachment_content_type :flower_photo, content_type: /\Aimage\/.*\Z/
	validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price, presence: true, numericality: { only_decimal: true, greater_than: 0 }
  validates :name, :description, presence: true
  accepts_nested_attributes_for :types, allow_destroy: true, reject_if: :all_blank
  paginates_per 9

end
