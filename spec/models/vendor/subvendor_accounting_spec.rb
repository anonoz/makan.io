require 'spec_helper'

describe Vendor::Subvendor, "Accounting" do

  let(:running_man) { create(:vendor_vendor) }

  let(:mamak) { create(:vendor_subvendor, vendor_vendor: running_man) }
  let(:bifc) { create(:vendor_subvendor, vendor_vendor: running_man) }

  let(:chit) { create(:order_chit, vendor_vendor: running_man).tap(&:accept!) }
  let(:chit2) { create(:order_chit, vendor_vendor: running_man).tap(&:accept!) }
  let(:ordered_chit) { create(:order_chit, vendor_vendor: running_man) }
  let(:rejected_chit) { create(:order_chit, vendor_vendor: running_man).tap(&:reject!) }
  let(:delivered_chit) do 
    create(:order_chit, vendor_vendor: running_man).tap do |chit| 
      chit.accept!
      chit.deliver!
    end
  end

  let(:nasi_lemak) {
    create(:food_menu, vendor_subvendor: mamak,
           subvendor_price: 1.40, base_price: 2.00)
  }
  let(:maggi_goreng) {
    create(:food_menu, vendor_subvendor: mamak,
           subvendor_price: 2.40, base_price: 3.50) 
  }
  let(:roti_kosong) {
    create(:food_menu, vendor_subvendor: bifc,
    	   subvendor_price: 0.8, base_price: 1.2)
  }
  let(:thosai_masala) {
    create(:food_menu, vendor_subvendor: bifc,
    	   subvendor_price: 2.5, base_price: 3)
  }

  let(:nasi_lemak_order) { build(:order_item, orderable: nasi_lemak) }
  let(:maggi_goreng_order) { build(:order_item, orderable: maggi_goreng) }
  let(:roti_kosong_order) { build(:order_item, orderable: roti_kosong) }
  let(:thosai_masala_order) { build(:order_item, orderable: thosai_masala) }

  it "lists ordered_items from single chit correctly" do
    chit.items << nasi_lemak_order
    chit.items << maggi_goreng_order

    expect(mamak.order_items).to eq [nasi_lemak_order, maggi_goreng_order]
  end

  it "lists ordered_items from multiple chits correctly" do
    chit.items << nasi_lemak_order
    chit2.items << maggi_goreng_order

    expect(mamak.order_items).to eq [nasi_lemak_order, maggi_goreng_order]
  end

  it "calculates items_ordered correctly" do
    nasi_lemak_order.quantity = 2
    chit.items << nasi_lemak_order
    maggi_goreng_order.quantity = 3
    chit2.items << maggi_goreng_order

    expect(mamak.items_ordered).to eq 5
  end

  it "knows when there is no order" do
    expect(mamak.items_ordered).to eq 0
  end

  it "calculates pay to mamak correctly run #1" do
    nasi_lemak_order.quantity = 3
    chit.items << nasi_lemak_order

    expect(mamak.amount_payable).to eq 4.2
  end

  it "calculates pay to mamak and bifc for orders in different date ranges correctly" do
    chit.items << nasi_lemak_order
    roti_kosong_order.quantity = 4
    chit.items << roti_kosong_order
    chit.update(created_at: "2015-05-01 12:30")

    chit2.items << maggi_goreng_order
    chit2.items << thosai_masala_order
    chit2.update(created_at: "2015-06-01 11:30")

    expect(mamak.amount_payable(from: "2015-04-25")).to eq 3.80
    expect(mamak.amount_payable(from: "2015-04-30", to: "2015-05-02")).to eq 1.4
    expect(mamak.amount_payable(from: "2015-06-01", to: "2015-06-05")).to eq 2.4
    expect(mamak.amount_payable(from: "2015-06-07")).to eq 0

    expect(bifc.amount_payable(to: "2015-04-01")).to eq 0
    expect(bifc.amount_payable(to: "2015-05-15")).to eq 3.2
    expect(bifc.amount_payable(to: "2015-06-14")).to eq 5.7
  end

  context "Chit status related" do
    it "does not factor in items that are rejected" do
      rejected_chit.items << nasi_lemak_order
      expect(mamak.amount_payable).to eq 0
    end

    it "does not factor in items that are not accepted yet" do
      ordered_chit.items << nasi_lemak_order
      expect(mamak.amount_payable).to eq 0
    end

    it "factors in items on an accepted chit" do
      ordered_chit.items << maggi_goreng_order
      ordered_chit.accept!
      expect(mamak.amount_payable).to eq 2.4
    end
  end

end
