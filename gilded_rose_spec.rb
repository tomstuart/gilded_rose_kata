require 'gilded_rose'

describe "#update_quality" do

  context "with a single" do
    let(:initial_sell_in) { 5 }
    let(:initial_quality) { 10 }
    let(:item) { Item.new(name, initial_sell_in, initial_quality) }

    before(:example) do
      update_quality([item])
    end

    context "normal item" do
      let(:name) { "NORMAL ITEM" }

      context "before sell date" do
        specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        specify { expect(item.quality).to eq(initial_quality-1) }
      end

      context "on sell date" do
        let(:initial_sell_in) { 0 }

        specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        specify { expect(item.quality).to eq(initial_quality-2) }
      end

      context "after sell date" do
        let(:initial_sell_in) { -10 }

        specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        specify { expect(item.quality).to eq(initial_quality-2) }
      end

      context "of zero quality" do
        let(:initial_quality) { 0 }

        specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        specify { expect(item.quality).to eq(0) }
      end
    end

    context "Aged Brie" do
      let(:name) { "Aged Brie" }

      context "before sell date" do
        specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        specify { expect(item.quality).to eq(initial_quality+1) }

        context "with max quality" do
          let(:initial_quality) { 50 }

          specify { expect(item.sell_in).to eq(initial_sell_in-1) }
          specify { expect(item.quality).to eq(initial_quality) }
        end
      end

      context "on sell date" do
        let(:initial_sell_in) { 0 }

        specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        specify { expect(item.quality).to eq(initial_quality+2) }

        context "near max quality" do
          let(:initial_quality) { 49 }

          specify { expect(item.sell_in).to eq(initial_sell_in-1) }
          specify { expect(item.quality).to eq(50) }
        end

        context "with max quality" do
          let(:initial_quality) { 50 }

          specify { expect(item.sell_in).to eq(initial_sell_in-1) }
          specify { expect(item.quality).to eq(initial_quality) }
        end
      end

      context "after sell date" do
        let(:initial_sell_in) { -10 }

        specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        specify { expect(item.quality).to eq(initial_quality+2) }

        context "with max quality" do
          let(:initial_quality) { 50 }

          specify { expect(item.sell_in).to eq(initial_sell_in-1) }
          specify { expect(item.quality).to eq(initial_quality) }
        end
      end
    end

    context "Sulfuras" do
      let(:initial_quality) { 80 }
      let(:name) { "Sulfuras, Hand of Ragnaros" }

      context "before sell date" do
        specify { expect(item.sell_in).to eq(initial_sell_in) }
        specify { expect(item.quality).to eq(initial_quality) }
      end

      context "on sell date" do
        let(:initial_sell_in) { 0 }

        specify { expect(item.sell_in).to eq(initial_sell_in) }
        specify { expect(item.quality).to eq(initial_quality) }
      end

      context "after sell date" do
        let(:initial_sell_in) { -10 }

        specify { expect(item.sell_in).to eq(initial_sell_in) }
        specify { expect(item.quality).to eq(initial_quality) }
      end
    end

    context "Backstage pass" do
      let(:name) { "Backstage passes to a TAFKAL80ETC concert" }

      context "long before sell date" do
        let(:initial_sell_in) { 11 }

        specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        specify { expect(item.quality).to eq(initial_quality+1) }

        context "at max quality" do
          let(:initial_quality) { 50 }

          specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        end
      end

      context "medium close to sell date (upper bound)" do
        let(:initial_sell_in) { 10 }

        specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        specify { expect(item.quality).to eq(initial_quality+2) }

        context "at max quality" do
          let(:initial_quality) { 50 }

          specify { expect(item.sell_in).to eq(initial_sell_in-1) }
          specify { expect(item.quality).to eq(initial_quality) }
        end
      end

      context "medium close to sell date (lower bound)" do
        let(:initial_sell_in) { 6 }

        specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        specify { expect(item.quality).to eq(initial_quality+2) }

        context "at max quality" do
          let(:initial_quality) { 50 }

          specify { expect(item.sell_in).to eq(initial_sell_in-1) }
          specify { expect(item.quality).to eq(initial_quality) }
        end
      end

      context "very close to sell date (upper bound)" do
        let(:initial_sell_in) { 5 }

        specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        specify { expect(item.quality).to eq(initial_quality+3) }

        context "at max quality" do
          let(:initial_quality) { 50 }

          specify { expect(item.sell_in).to eq(initial_sell_in-1) }
          specify { expect(item.quality).to eq(initial_quality) }
        end
      end

      context "very close to sell date (lower bound)" do
        let(:initial_sell_in) { 1 }

        specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        specify { expect(item.quality).to eq(initial_quality+3) }

        context "at max quality" do
          let(:initial_quality) { 50 }

          specify { expect(item.sell_in).to eq(initial_sell_in-1) }
          specify { expect(item.quality).to eq(initial_quality) }
        end
      end

      context "on sell date" do
        let(:initial_sell_in) { 0 }

        specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        specify { expect(item.quality).to eq(0) }
      end

      context "after sell date" do
        let(:initial_sell_in) { -10 }

        specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        specify { expect(item.quality).to eq(0) }
      end
    end

    context "conjured item", :skip do
      let(:name) { "Conjured Mana Cake" }

      context "before the sell date" do
        let(:initial_sell_in) { 5 }

        specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        specify { expect(item.quality).to eq(initial_quality-2) }

        context "at zero quality" do
          let(:initial_quality) { 0 }

          specify { expect(item.sell_in).to eq(initial_sell_in-1) }
          specify { expect(item.quality).to eq(initial_quality) }
        end
      end

      context "on sell date" do
        let(:initial_sell_in) { 0 }

        specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        specify { expect(item.quality).to eq(initial_quality-4) }

        context "at zero quality" do
          let(:initial_quality) { 0 }

          specify { expect(item.sell_in).to eq(initial_sell_in-1) }
          specify { expect(item.quality).to eq(initial_quality) }
        end
      end

      context "after sell date" do
        let(:initial_sell_in) { -10 }

        specify { expect(item.sell_in).to eq(initial_sell_in-1) }
        specify { expect(item.quality).to eq(initial_quality-4) }

        context "at zero quality" do
          let(:initial_quality) { 0 }

          specify { expect(item.sell_in).to eq(initial_sell_in-1) }
          specify { expect(item.quality).to eq(initial_quality) }
        end
      end
    end
  end

  context "with several objects" do
    let(:items) {
      [
        Item.new("NORMAL ITEM", 5, 10),
        Item.new("Aged Brie", 3, 10),
      ]
    }

    before(:example) do
      update_quality(items)
    end

    specify { expect(items[0].quality).to eq(9) }
    specify { expect(items[0].sell_in).to eq(4) }

    specify { expect(items[1].quality).to eq(11) }
    specify { expect(items[1].sell_in).to eq(2) }
  end
end
