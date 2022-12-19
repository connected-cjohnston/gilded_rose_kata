class GildedRose
  def update_quality(items)
    items.each { |item| update(item) }
  end

  def update(item)
    if item.name == 'Aged Brie'
      update_aged_brie(item)
    elsif item.name == 'Sulfuras, Hand of Ragnaros'
      update_sulfuras(item)
    elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
      update_backstage_pass(item)
    else
      item.update
    end
  end



  def update_aged_brie(item)
    item.sell_in -= 1

    item.quality = 50 and return if item.quality == 50

    item.quality += 1
    item.quality += 1 if item.sell_in < 0
  end

  def update_sulfuras(item)

  end

  def update_backstage_pass(item)
    item.sell_in -= 1

    item.quality = 50 and return if item.quality == 50
    item.quality = 0 and return if item.sell_in < 0

    item.quality += 1
    item.quality += 1 if item.sell_in < 10
    item.quality += 1 if item.sell_in < 5
  end


end


class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def update

  end

  def self.create(name, sell_in, quality)
    if name == 'NORMAL ITEM'
      NormalItem.new('NORMAL ITEM', sell_in, quality)
    elsif name == 'Conjured Mana Cake'
      ConjuredManaItem.new('Conjured Mana Cake', sell_in, quality)
    else
      Item.new(name, sell_in, quality)
    end
  end
end

class NormalItem < Item
  def update
    @sell_in -= 1

    @quality = 0 and return if @quality == 0

    @quality -= 1
    @quality -= 1 if @sell_in < 0
  end
end

class ConjuredManaItem < Item
  def update
    @sell_in -= 1

    @quality = 0 and return if @quality == 0

    if @sell_in != 0
      @quality -= 2
    end
  end
end


# DO NOT CHANGE THINGS BELOW -----------------------------------------

# Item = Struct.new(:name, :sell_in, :quality)
