class Order < ActiveRecord::Base
	include AASM
	
  before_save :calculate_total
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :total, presence: true, numericality: { only_decimal: true, greater_than_or_equal_to: 0 }

  aasm_column :state

  aasm do
    state :created, :initial => true
    state :confirmed
    state :payed
    state :completed
    state :canceled

    event :finish do
      transitions :from => :created, :to => :confirmed
    end

    event :pay do
      transitions :from => :confirmed, :to => :payed
    end

    event :deliver do
      transitions :from => :payed, :to => :completed
    end

    event :cancel do
      transitions :from => [:confirmed, :payed], :to => :canceled
    end
  end

  def calculate_total
    current = 0
    self.order_items.each do |item|
      current += item.subtotal
    end
    self.total = current
  end

end
