class Item
  attr_reader :quality, :days_remaining

  def initialize(quality, days_remaining)
    @quality = quality
    @days_remaining = days_remaining
  end

  def tick
  end
end

class Normal < Item
  def tick
    @days_remaining -= 1
    return if quality <= 0

    @quality -= 1
    @quality -= 1 if @days_remaining <= 0
  end
end

class AgedBrie < Item
  def tick
    @days_remaining -= 1
    return if @quality >= 50

    @quality += 1
    @quality += 1 if @days_remaining <= 0 && @quality < 50
  end
end

class Backstage < Item
  def tick
    @days_remaining -= 1

    return if @quality >= 50
    return @quality = 0 if @days_remaining < 0

    @quality += 1
    @quality += 1 if @days_remaining < 10
    @quality += 1 if @days_remaining < 5
  end
end

class GildedRose
  attr_reader :name, :quality, :days_remaining

  ITEMS = Hash.new(Item).tap { |h|
    h['NORMAL ITEM'] = Normal
    h['Aged Brie'] = AgedBrie
    h['Backstage passes to a TAFKAL80ETC concert'] = Backstage
  }

  def initialize(name, quality, days_remaining)
    @item = ITEMS[name].new(quality, days_remaining)
  end

  def tick
    @item.tick
  end

  def quality
    @item.quality
  end

  def days_remaining
    @item.days_remaining
  end
end
