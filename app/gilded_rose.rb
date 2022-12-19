class GildedRose
  def update_quality(items)
    items.each { |item| update(item) }
  end

  def update(item)
    item.update
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
    elsif name == 'Aged Brie'
      AgedBrie.new('Aged Brie', sell_in, quality)
    elsif name == 'Sulfuras, Hand of Ragnaros'
      Item.new('Sulfuras, Hand of Ragnaros', sell_in, quality)
    elsif name == 'Backstage passes to a TAFKAL80ETC concert'
      BackstatePass.new('Backstage passes to a TAFKAL80ETC concert', sell_in, quality)
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

class AgedBrie < Item
  def update
    @sell_in -= 1

    @quality = 50 and return if @quality == 50

    @quality += 1
    @quality += 1 if @sell_in < 0
  end
end

class BackstatePass < Item
  def update
    @sell_in -= 1

    @quality = 50 and return if @quality == 50
    @quality = 0 and return if @sell_in < 0

    @quality += 1
    @quality += 1 if @sell_in < 10
    @quality += 1 if @sell_in < 5
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
