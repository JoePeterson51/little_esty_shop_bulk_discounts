class Discount < ApplicationRecord
  validates_presence_of :percentage, :quantity_required

  belongs_to :merchant
end