class GildedRose
  attr_reader :name, :quality, :days_remaining

  def initialize(name, quality, days_remaining)
    @item = klass_for(name).new(quality, days_remaining)
  end

  def klass_for(name)
    case name
    when 'NORMAL ITEM'
      Normal
    when 'Aged Brie'
      AgedBrie
    when 'Sulfuras, Hand of Ragnaros'
      Sulfuras
    when 'Backstage passes to a TAFKAL80ETC concert'
      Backstage
    end
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

  class Normal
    attr_reader :quality, :days_remaining

    def initialize(quality, days_remaining)
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
    attr_reader :quality, :days_remaining

    def initialize(quality, days_remaining)
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
    attr_reader :quality, :days_remaining

    def initialize(quality, days_remaining)
      @quality = quality
      @days_remaining = days_remaining
    end

    def tick
    end
  end

  class Backstage
    attr_reader :quality, :days_remaining

    def initialize(quality, days_remaining)
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
