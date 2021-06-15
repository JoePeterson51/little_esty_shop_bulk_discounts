require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe '#discounts_applied' do
    it 'returns the bulk discount applied if any' do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @discount_4 = @merchant1.discounts.create!(percentage: 10, quantity_required: 5)
      @discount_1 = @merchant1.discounts.create!(percentage: 20, quantity_required: 10)
      @discount_2 = @merchant1.discounts.create!(percentage: 25, quantity_required: 15)
      @discount_3 = @merchant1.discounts.create!(percentage: 35, quantity_required: 30)
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 15, unit_price: 10, status: 1)

      expect(@ii_1.discounts_applied).to eq(@discount_1)
      expect(@ii_11.discounts_applied).to eq(@discount_2)
    end
  end
end
