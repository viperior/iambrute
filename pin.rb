class Pin

  attr_reader :is_valid_pin, :pin

  def initialize(pin_text)
    @pin = nil
    @pin_text = pin_text
    @is_valid_pin = false

    if (looks_like_integer)
      convert_to_integer
      @is_valid_pin = get_pin_validity
    end
  end

  def convert_to_integer
    @pin = @pin_text.to_i
  end

  def get_pin_validity
    return @pin >= 1000 && @pin <= 9999
  end

  def looks_like_integer
    return @pin_text.to_s.match(/^\d+$/)
  end

end
