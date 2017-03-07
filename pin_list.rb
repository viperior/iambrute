class PinList

  attr_reader :pins

  def initialize()
    @pins = Array.new
    @pin_pool = Array.new

    generate_pool
    add_repeating_pins
    add_thousands_pins
    add_sequence_pins
    add_year_pins
    update_pool
    add_remaining_pins
  end

  def add_pin(pin)
    if( pin_not_in_pool pin )
      @pins.push(pin)
    end
  end

  def add_remaining_pins
    @pin_pool = @pin_pool.shuffle
    @pins += @pin_pool
  end

  def add_repeating_pins
    (0..9).each do |i|
      pin = (i * 1000) + (i * 100) + (i * 10) + i
      add_pin(pin)
    end
  end

  def add_sequence_pins
    (0..9).each do |i|
      if( i <= 6 )
        pin = (i * 1000) + (((i + 1) % 10) * 100) + (((i + 2) % 10) * 10) + ((i + 3) % 10)
        add_pin(pin)
      end

      if( i >= 3 )
        pin = (i * 1000) + (((i - 1) % 10) * 100) + (((i - 2) % 10) * 10) + ((i - 3) % 10)
        add_pin(pin)
      end
    end
  end

  def add_thousands_pins
    (1..9).each do |i|
      pin = i * 1000
      add_pin(pin)
    end
  end

  def add_year_pins
    (1917..2017).each do |pin|
      add_pin(pin)
    end
  end

  def generate_pool
    (0..9999).each do |i|
      @pin_pool.push(i)
    end
  end

  def pin_not_in_pool(pin)
    return !(@pins.include? pin)
  end

  def update_pool
    @pin_pool -= @pins
  end

end
