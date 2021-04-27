require 'rspec/given'
require 'gilded_rose'

describe '#update_quality' do
  context 'with a single' do
    let(:days_remaining) { 5 }
    let(:initial_quality) { 10 }

    context "normal item" do
      let(:name) { "NORMAL ITEM" }

      context "before sell date" do
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(initial_quality - 1)
          expect(item.days_remaining).to eq(days_remaining - 1)
        }
      end

      context "on sell date" do
        let(:days_remaining) { 0 }
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(initial_quality - 2)
          expect(item.days_remaining).to eq(days_remaining - 1)
        }
      end

      context "after sell date" do
        let(:days_remaining) { -10 }
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(initial_quality - 2)
          expect(item.days_remaining).to eq(days_remaining - 1)
        }
      end

      context "of zero quality" do
        let(:initial_quality) { 0 }
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(0)
          expect(item.days_remaining).to eq(days_remaining - 1)
        }
      end
    end

    context "Aged Brie" do
      let(:name) { "Aged Brie" }

      context "before sell date" do
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(initial_quality + 1)
          expect(item.days_remaining).to eq(days_remaining - 1)
        }

        context "with max quality" do
          let(:initial_quality) { 50 }
          Then {
            item = GildedRose.new(name, initial_quality, days_remaining)
            item.tick
            expect(item.quality).to eq(initial_quality)
            expect(item.days_remaining).to eq(days_remaining - 1)
          }
        end
      end

      context 'on sell date' do
        let(:days_remaining) { 0 }
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(initial_quality + 2)
          expect(item.days_remaining).to eq(days_remaining - 1)
        }

        context 'near max quality' do
          let(:initial_quality) { 49 }
          Then {
            item = GildedRose.new(name, initial_quality, days_remaining)
            item.tick
            expect(item.quality).to eq(50)
            expect(item.days_remaining).to eq(days_remaining - 1)
          }
        end

        context 'with max quality' do
          let(:initial_quality) { 50 }
          Then {
            item = GildedRose.new(name, initial_quality, days_remaining)
            item.tick
            expect(item.quality).to eq(initial_quality)
            expect(item.days_remaining).to eq(days_remaining - 1)
          }
        end
      end

      context 'after sell date' do
        let(:days_remaining) { -10 }
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(initial_quality + 2)
          expect(item.days_remaining).to eq(days_remaining - 1)
        }

        context 'with max quality' do
          let(:initial_quality) { 50 }
          Then {
            item = GildedRose.new(name, initial_quality, days_remaining)
            item.tick
            expect(item.quality).to eq(initial_quality)
            expect(item.days_remaining).to eq(days_remaining - 1)
          }
        end
      end
    end

    context 'Sulfuras' do
      let(:initial_quality) { 80 }
      let(:name) { 'Sulfuras, Hand of Ragnaros' }

      context 'before sell date' do
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(initial_quality)
          expect(item.days_remaining).to eq(days_remaining)
        }
      end

      context 'on sell date' do
        let(:days_remaining) { 0 }
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(initial_quality)
          expect(item.days_remaining).to eq(days_remaining)
        }
      end

      context 'after sell date' do
        let(:days_remaining) { -10 }
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(initial_quality)
          expect(item.days_remaining).to eq(days_remaining)
        }
      end
    end

    context 'Backstage pass' do
      let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }

      context 'long before sell date' do
        let(:days_remaining) { 11 }
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(initial_quality + 1)
          expect(item.days_remaining).to eq(days_remaining - 1)
        }

        context 'at max quality' do
          let(:initial_quality) { 50 }
        end
      end

      context 'medium close to sell date (upper bound)' do
        let(:days_remaining) { 10 }
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(initial_quality + 2)
          expect(item.days_remaining).to eq(days_remaining - 1)
        }

        context 'at max quality' do
          let(:initial_quality) { 50 }
          Then {
            item = GildedRose.new(name, initial_quality, days_remaining)
            item.tick
            expect(item.quality).to eq(initial_quality)
            expect(item.days_remaining).to eq(days_remaining - 1)
          }
        end
      end

      context 'medium close to sell date (lower bound)' do
        let(:days_remaining) { 6 }
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(initial_quality + 2)
          expect(item.days_remaining).to eq(days_remaining - 1)
        }

        context 'at max quality' do
          let(:initial_quality) { 50 }
          Then {
            item = GildedRose.new(name, initial_quality, days_remaining)
            item.tick
            expect(item.quality).to eq(initial_quality)
            expect(item.days_remaining).to eq(days_remaining - 1)
          }
        end
      end

      context 'very close to sell date (upper bound)' do
        let(:days_remaining) { 5 }
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(initial_quality + 3)
          expect(item.days_remaining).to eq(days_remaining - 1)
        }

        context 'at max quality' do
          let(:initial_quality) { 50 }
          Then {
            item = GildedRose.new(name, initial_quality, days_remaining)
            item.tick
            expect(item.quality).to eq(initial_quality)
            expect(item.days_remaining).to eq(days_remaining - 1)
          }
        end
      end

      context 'very close to sell date (lower bound)' do
        let(:days_remaining) { 1 }
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(initial_quality + 3)
          expect(item.days_remaining).to eq(days_remaining - 1)
        }

        context 'at max quality' do
          let(:initial_quality) { 50 }
          Then {
            item = GildedRose.new(name, initial_quality, days_remaining)
            item.tick
            expect(item.quality).to eq(initial_quality)
            expect(item.days_remaining).to eq(days_remaining - 1)
          }
        end
      end

      context 'on sell date' do
        let(:days_remaining) { 0 }
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(0)
          expect(item.days_remaining).to eq(days_remaining - 1)
        }
      end

      context 'after sell date' do
        let(:days_remaining) { -10 }
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(0)
          expect(item.days_remaining).to eq(days_remaining - 1)
        }
      end
    end

    context "conjured item" do
      before { skip 'yet to be implemented' }
      let(:name) { 'Conjured Mana Cake' }

      context 'before the sell date' do
        let(:days_remaining) { 5 }
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(initial_quality - 2)
          item.days_remaining.to eq(days_remaining - 1)
        }

        context 'at zero quality' do
          let(:initial_quality) { 0 }
          Then {
            item = GildedRose.new(name, initial_quality, days_remaining)
            item.tick
            expect(item.quality).to eq(initial_quality)
            item.days_remaining.to eq(days_remaining - 1)
          }
        end
      end

      context 'on sell date' do
        let(:days_remaining) { 0 }
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(initial_quality - 4)
          item.days_remaining.to eq(days_remaining - 1)
        }

        context 'at zero quality' do
          let(:initial_quality) { 0 }
          Then {
            item = GildedRose.new(name, initial_quality, days_remaining)
            item.tick
            expect(item.quality).to eq(initial_quality)
            item.days_remaining.to eq(days_remaining - 1)
          }
        end
      end

      context 'after sell date' do
        let(:days_remaining) { -10 }
        Then {
          item = GildedRose.new(name, initial_quality, days_remaining)
          item.tick
          expect(item.quality).to eq(initial_quality - 4)
          item.days_remaining.to eq(days_remaining - 1)
        }

        context 'at zero quality' do
          let(:initial_quality) { 0 }
          Then {
            item = GildedRose.new(name, initial_quality, days_remaining)
            item.tick
            expect(item.quality).to eq(initial_quality)
            item.days_remaining.to eq(days_remaining - 1)
          }
        end
      end
    end
  end
end
