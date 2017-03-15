require 'spec_helper'

describe Order::Chit, "Promotable Spec" do
  let(:order_chit) { create(:order_chit, from_web: false, caller_is_student: true) }
  let(:nasi_lemak) { create(:food_menu, kena_delivery_fee: true, base_price: 3.00)}
  let(:maggi_goreng) { create(:food_menu, kena_delivery_fee: true, base_price: 4.50)}
  let(:nasi_lemak_order) { create(:order_item, orderable: nasi_lemak) }
  let(:maggi_goreng_order) { create(:order_item, orderable: maggi_goreng) }

  it "adjusts to deduct delivery fee from order made by student" do
    order_chit.items << build(:order_item, orderable: nasi_lemak)

    expect(order_chit.promo_adjustments).to be_any
    expect(order_chit.calculate_subtotal.amount).to eq 3
  end

  context "#promo_usages" do
    it "persists the student delivery waiver promo usage on save" do
      expect {
        order_chit.items << nasi_lemak_order
        order_chit.save
      }.to change(Promo::Usage, :count).by 1
    end

    it "doesn't save more than 1 promo usage of same promo type" do
      expect {
        order_chit.items << nasi_lemak_order
        order_chit.save
      }.to change(Promo::Usage, :count).by 1

      expect {
        order_chit.items << nasi_lemak_order
        order_chit.save
      }.to change(Promo::Usage, :count).by 0
    end

    it "updates the delivery waiver if one more item is added" do
      order_chit.items << nasi_lemak_order
      order_chit.save

      expect {
      	order_chit.items << maggi_goreng_order
      	order_chit.save
      }.to change {
      	order_chit.promo_usages.reload.last.reload.adjustment.amount
      }.by -0.45
    end

    it "revokes the student delivery waiver if all items with delivery fee are removed" do
      order_chit.items << nasi_lemak_order
      order_chit.items = []
      order_chit.save

      expect(order_chit.promo_adjustments).to be_empty
    end

    it "destroys the promo usage record if all items with deliver fee are removed" do
      order_chit.items << nasi_lemak_order
      order_chit.save

      expect {
        order_chit.items = []
        order_chit.save
      }.to change(Promo::Usage, :count).by -1
    end
  end

  context "from Order::Item" do
    it "enables student delivery waiver if item with delivery fee is saved" do
      expect {
        nasi_lemak_order.update(order_chit_id: order_chit.id)
      }.to change {
        order_chit.promo_usages.reload.count
      }.by 1
    end

    it "disables delivery waiver if item with delivery fee is destroyed" do
      nasi_lemak_order.update(order_chit_id: order_chit.id)
      expect(order_chit.promo_usages.count).to eq 1

      expect {
        # binding.remote_pry
        nasi_lemak_order.destroy
      }.to change {
        order_chit.promo_usages.reload.count
      }.by -1
    end
  end

end
