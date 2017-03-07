class PasswordFile

  attr_reader :status

  def initialize(filename)
    @filename = filename
  end

  def exists
    return File.file?(@filename)
  end

  def is_valid_file
    valid = true
    f = File.open(@filename, 'r')

    f.each_line do |line|
      current_pin = Pin.new(line)

      if( !current_pin.is_valid_pin )
        valid = false
      end
    end

    f.close

    return valid
  end

  def pins_text
    text = ''
    pins_array = PinList.new.pins

    pins_array.each_with_index do |pin, index|
      text += pin.to_s

      if( pin != pins_array.last )
        text += '\n'
      end
    end
  end

  def rebuild
    f = File.open(@filename, 'w+')
    f.puts pins_text
    f.close
  end

  def status
    if( exists )
      p 'File exists.'

      if( is_valid_file )
        p 'File is in the correct format.'
      else
        p 'File is not in the correct format.'
      end
    else
      p 'File does not exist.'
    end
  end

end
