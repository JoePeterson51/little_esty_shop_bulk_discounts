class Discount < ApplicationRecord
  validates_presence_of :percentage, presence: true, numericality: true
  validates_presence_of :quantity_required, presence: true, numericality: true
  belongs_to :merchant
end