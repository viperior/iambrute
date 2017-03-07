require_relative('password_file.rb')
require_relative('pin.rb')
require_relative('pin_list.rb')

def main
  filename = 'brute.txt'

  p 'I am Brute!'
  p "Checking password file, #{filename}..."

  password_file = PasswordFile.new(filename)
  password_file.status

  p 'Would you like to build a fresh password file? [y/n]'
  rebuild = gets.chomp.downcase

  if(rebuild == 'y')
    p "Rebuilding #{filename}..."
    password_file.rebuild
    p 'File successfully rebuilt. Terminating program...'
  else
    p 'Terminating program without rebuilding file...'
  end
end

main
