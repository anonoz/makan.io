require 'spec_helper'

describe Vendor::Subvendor, "Accounting" do

  let(:mamak) { create(:vendor_subvendor) }
  let(:bifc) { create(:vendor_subvendor) }

  let(:chit) { create(:order_chit) }
  let(:chit2) { create(:order_chit) }

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

  let(:nasi_lemak_order) { build(:order_item, food_menu: nasi_lemak) }
  let(:maggi_goreng_order) { build(:order_item, food_menu: maggi_goreng) }
  let(:roti_kosong_order) { build(:order_item, food_menu: roti_kosong) }
  let(:thosai_masala_order) { build(:order_item, food_menu: thosai_masala) }

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
    chit.items.update_all(created_at: "2015-05-01")

    chit2.items << maggi_goreng_order
    chit2.items << thosai_masala_order
    chit2.items.update_all(created_at: "2015-06-01")

    expect(mamak.amount_payable(from: "2015-04-25")).to eq 3.80
    expect(mamak.amount_payable(from: "2015-04-30", to: "2015-05-02")).to eq 1.4
    expect(mamak.amount_payable(from: "2015-06-01", to: "2015-06-05")).to eq 2.4
    expect(mamak.amount_payable(from: "2015-06-07")).to eq 0

    expect(bifc.amount_payable(to: "2015-04-01")).to eq 0
    expect(bifc.amount_payable(to: "2015-05-15")).to eq 3.2
    expect(bifc.amount_payable(to: "2015-06-14")).to eq 5.7
  end

  it "does not factor in items that are rejected"
  it "does not factor in items that are not accepted"

end
