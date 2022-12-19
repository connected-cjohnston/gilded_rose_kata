class GildedRose
  def update_quality(items)
    items.each do |item|
      if item.name == 'NORMAL ITEM'
        handle_normal_item(item)
      elsif item.name == 'Conjured Mana Cake'
        handle_conjured_mana_item(item)
      elsif item.name == 'Aged Brie'
        handle_aged_brie(item)
      elsif item.name == 'Sulfuras, Hand of Ragnaros'
        handle_sulfuras(item)
      elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
        handle_backstage_pass(item)
      else
        if item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert'
          if item.quality > 0
            if item.name != 'Sulfuras, Hand of Ragnaros'
              item.quality -= 1
            end
          end
        else
          if item.quality < 50
            item.quality += 1
            if item.name == 'Backstage passes to a TAFKAL80ETC concert'
              if item.sell_in < 11
                if item.quality < 50
                  item.quality += 1
                end
              end
              if item.sell_in < 6
                if item.quality < 50
                  item.quality += 1
                end
              end
            end
          end
        end
        if item.name != 'Sulfuras, Hand of Ragnaros'
          item.sell_in -= 1
        end
        if item.sell_in < 0
          if item.name != "Aged Brie"
            if item.name != 'Backstage passes to a TAFKAL80ETC concert'
              if item.quality > 0
                if item.name != 'Sulfuras, Hand of Ragnaros'
                  item.quality -= 1
                end
              end
            else
              item.quality = item.quality - item.quality
            end
          else
            if item.quality < 50
              item.quality += 1
            end
          end
        end
      end
    end
  end

  def handle_normal_item(item)
    item.sell_in -= 1

    item.quality = 0 and return if item.quality == 0

    item.quality -= 1
    item.quality -= 1 if item.sell_in < 0
  end

  def handle_aged_brie(item)
    item.sell_in -= 1

    item.quality = 50 and return if item.quality == 50

    item.quality += 1
    item.quality += 1 if item.sell_in < 0
  end

  def handle_sulfuras(item)

  end

  def handle_backstage_pass(item)
    item.sell_in -= 1

    item.quality = 50 and return if item.quality == 50
    item.quality = 0 and return if item.sell_in < 0

    item.quality += 1
    item.quality += 1 if item.sell_in < 10
    item.quality += 1 if item.sell_in < 5
  end

  def handle_conjured_mana_item(item)
    item.sell_in -= 1

    item.quality = 0 and return if item.quality == 0

    if item.sell_in != 0
      item.quality -= 2
    end
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)
