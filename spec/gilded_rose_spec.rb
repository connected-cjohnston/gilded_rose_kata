require 'rspec/given'
require './src/gilded_rose'

describe '#update_quality' do
  context 'with a single' do
    let(:initial_sell_in) { 5 }
    let(:initial_quality) { 10 }
    let(:item) { GildedRose.new(name, initial_quality, initial_sell_in) }

    before { item.tick }

    context "normal item" do
      let(:name) { "NORMAL ITEM" }

      Invariant { expect(item.days_remaining).to eq(initial_sell_in - 1) }

      context "before sell date" do
        Then { expect(item.quality).to eq(initial_quality - 1) }
      end

      context "on sell date" do
        let(:initial_sell_in) { 0 }
        Then { expect(item.quality).to eq(initial_quality - 2) }
      end

      context "after sell date" do
        let(:initial_sell_in) { -10 }
        Then { expect(item.quality).to eq(initial_quality - 2) }
      end

      context "of zero quality" do
        let(:initial_quality) { 0 }
        Then { expect(item.quality).to eq(0) }
      end
    end

    context "Aged Brie" do
      let(:name) { "Aged Brie" }

      Invariant { expect(item.days_remaining).to eq(initial_sell_in - 1) }

      context "before sell date" do
        Then { expect(item.quality).to eq(initial_quality + 1) }

        context "with max quality" do
          let(:initial_quality) { 50 }
          Then { expect(item.quality).to eq(initial_quality) }
        end
      end

      context 'on sell date' do
        let(:initial_sell_in) { 0 }
        Then { expect(item.quality).to eq(initial_quality + 2) }

        context 'near max quality' do
          let(:initial_quality) { 49 }
          Then { expect(item.quality).to eq(50) }
        end

        context 'with max quality' do
          let(:initial_quality) { 50 }
          Then { expect(item.quality).to eq(initial_quality) }
        end
      end

      context 'after sell date' do
        let(:initial_sell_in) { -10 }
        Then { expect(item.quality).to eq(initial_quality + 2) }

        context 'with max quality' do
          let(:initial_quality) { 50 }
          Then { expect(item.quality).to eq(initial_quality) }
        end
      end
    end

    context 'Sulfuras' do
      let(:initial_quality) { 80 }
      let(:name) { 'Sulfuras, Hand of Ragnaros' }

      Invariant { expect(item.days_remaining).to eq(initial_sell_in) }

      context 'before sell date' do
        Then { expect(item.quality).to eq(initial_quality) }
      end

      context 'on sell date' do
        let(:initial_sell_in) { 0 }
        Then { expect(item.quality).to eq(initial_quality) }
      end

      context 'after sell date' do
        let(:initial_sell_in) { -10 }
        Then { expect(item.quality).to eq(initial_quality) }
      end
    end

    context 'Backstage pass' do
      let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }

      Invariant { expect(item.days_remaining).to eq(initial_sell_in - 1) }

      context 'long before sell date' do
        let(:initial_sell_in) { 11 }
        Then { expect(item.quality).to eq(initial_quality + 1) }

        context 'at max quality' do
          let(:initial_quality) { 50 }
        end
      end

      context 'medium close to sell date (upper bound)' do
        let(:initial_sell_in) { 10 }
        Then { expect(item.quality).to eq(initial_quality + 2) }

        context 'at max quality' do
          let(:initial_quality) { 50 }
          Then { expect(item.quality).to eq(initial_quality) }
        end
      end

      context 'medium close to sell date (lower bound)' do
        let(:initial_sell_in) { 6 }
        Then { expect(item.quality).to eq(initial_quality + 2) }

        context 'at max quality' do
          let(:initial_quality) { 50 }
          Then { expect(item.quality).to eq(initial_quality) }
        end
      end

      context 'very close to sell date (upper bound)' do
        let(:initial_sell_in) { 5 }
        Then { expect(item.quality).to eq(initial_quality + 3) }

        context 'at max quality' do
          let(:initial_quality) { 50 }
          Then { expect(item.quality).to eq(initial_quality) }
        end
      end

      context 'very close to sell date (lower bound)' do
        let(:initial_sell_in) { 1 }
        Then { expect(item.quality).to eq(initial_quality + 3) }

        context 'at max quality' do
          let(:initial_quality) { 50 }
          Then { expect(item.quality).to eq(initial_quality) }
        end
      end

      context 'on sell date' do
        let(:initial_sell_in) { 0 }
        Then { expect(item.quality).to eq(0) }
      end

      context 'after sell date' do
        let(:initial_sell_in) { -10 }
        Then { expect(item.quality).to eq(0) }
      end
    end

    context "conjured item" do
      before { skip }
      let(:name) { 'Conjured Mana Cake' }

      Invariant { item.days_remaining.to eq(initial_sell_in - 1) }

      context 'before the sell date' do
        let(:initial_sell_in) { 5 }
        Then { expect(item.quality).to eq(initial_quality - 2) }

        context 'at zero quality' do
          let(:initial_quality) { 0 }
          Then { expect(item.quality).to eq(initial_quality) }
        end
      end

      context 'on sell date' do
        let(:initial_sell_in) { 0 }
        Then { expect(item.quality).to eq(initial_quality - 4) }

        context 'at zero quality' do
          let(:initial_quality) { 0 }
          Then { expect(item.quality).to eq(initial_quality) }
        end
      end

      context 'after sell date' do
        let(:initial_sell_in) { -10 }
        Then { expect(item.quality).to eq(initial_quality - 4) }

        context 'at zero quality' do
          let(:initial_quality) { 0 }
          Then { expect(item.quality).to eq(initial_quality) }
        end
      end
    end
  end
end
