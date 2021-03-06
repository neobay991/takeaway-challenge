require 'order'

describe Order do

  describe 'initialize' do

    it 'should create an empty takeaway_order array' do
      expect(subject.takeaway_order).to be_empty
    end

    it 'should create an empty order balance' do
      expect(subject.balance).to eq(0)
    end

    it 'should set order complete as false' do
      expect(subject.order_complete).to eq(false)
    end

  end

  context 'customer viewing menu of dishes' do
    describe '#view_list' do

      let(:menu) {
        [{ :name => "sushi festival", :price => 3 },
      { :name => "chicken teriyaki dragon roll", :price => 4 },
      { :name => "salmon & avo dragon roll", :price => 5 },
      { :name => "spicy tuna dragon roll", :price => 5 },
      { :name => "veggie dragon roll", :price => 6 }]
      }

      it 'should return a list of dishes' do
        expect(subject.view_list).to eq menu
      end

    end
  end

  describe '#add_order' do

    let(:dish_1) { { :name => "sushi festival", :price => 3 } }
    let(:dish_2) { { :name => "chicken teriyaki dragon roll", :price => 4 } }

    it 'should allow to select some number of several available dishes' do
      subject.add_order(dish_1)
      subject.add_order(dish_2)
      expect(subject.takeaway_order.length).to eq(2)
    end

    it 'should add an order balance' do
      subject.add_order(dish_1)
      subject.add_order(dish_2)
      expect(subject.balance).to eq(7)
    end
  end

  describe '#complete_order' do

    let(:dish_1) { { :name => "sushi festival", :price => 3 } }
    let(:dish_2) { { :name => "chicken teriyaki dragon roll", :price => 4 } }

    it 'raise an error if the order balance does not match sum of dishes' do
      subject.add_order(dish_1)
      subject.add_order(dish_2)
      expect { subject.complete_order }.to_not raise_error "balance does not match: check order"
    end

    it 'raise an error if there are no dishes added to the order' do
      expect { subject.complete_order }.to raise_error "your order is empty: add some dishes first"
    end

    it 'balance should match order' do
      subject.add_order(dish_1)
      subject.add_order(dish_2)
      subject.complete_order
      expect(subject.order_complete).to eq(true)
    end
  end

end
