class GildedRose
  attr_reader :name, :quality, :days_remaining

  def initialize(name, quality, days_remaining)
    @name = name
    @quality = quality
    @days_remaining = days_remaining
  end

  def tick
    case name
    when 'NORMAL ITEM'
      @item = Normal.new(name, quality, days_remaining)
      @item.tick
    when 'Aged Brie'
      @item = AgedBrie.new(name, quality, days_remaining)
      @item.tick
    when 'Sulfuras, Hand of Ragnaros'
      @item = Sulfuras.new(name, quality, days_remaining)
      @item.tick
    when 'Backstage passes to a TAFKAL80ETC concert'
      @item = Backstage.new(name, quality, days_remaining)
      @item.tick
    end
  end

  def quality
    return @item.quality if @item
    @quality
  end

  def days_remaining
    return @item.days_remaining if @item
    @days_remaining
  end

  class Normal
    attr_reader :name, :quality, :days_remaining

    def initialize(name, quality, days_remaining)
      @name = name
      @quality = quality
      @days_remaining = days_remaining
    end

    def tick
      @days_remaining -= 1
      return if quality <= 0

      @quality -= 1
      @quality -= 1 if @days_remaining <= 0
    end
  end

  class AgedBrie
    attr_reader :name, :quality, :days_remaining

    def initialize(name, quality, days_remaining)
      @name = name
      @quality = quality
      @days_remaining = days_remaining
    end

    def tick
      @days_remaining -= 1
      return if @quality >= 50

      @quality += 1
      @quality += 1 if @days_remaining <= 0 && @quality < 50
    end
  end

  class Sulfuras
    attr_reader :name, :quality, :days_remaining

    def initialize(name, quality, days_remaining)
      @name = name
      @quality = quality
      @days_remaining = days_remaining
    end

    def tick
    end
  end

  class Backstage
    attr_reader :name, :quality, :days_remaining

    def initialize(name, quality, days_remaining)
      @name = name
      @quality = quality
      @days_remaining = days_remaining
    end

    def tick
      @days_remaining -= 1

      return if @quality >= 50
      return @quality = 0 if @days_remaining < 0

      @quality += 1
      @quality += 1 if @days_remaining < 10
      @quality += 1 if @days_remaining < 5
    end
  end
end
