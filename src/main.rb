require_relative "./initialize"
require "utilities/encryptor"
require "utilities/password_file"
require "utilities/key_manager"
require "commands/command_dispatcher"
require "io/console"

class Main
  def run
    print("Please input key-box password: ")
    password = STDIN.noecho(&:gets).chomp
    puts

    PasswordFile.write(@encryptor.encrypt("{}")) unless PasswordFile.exist?

    @encryptor = Encryptor.new(password)

    @key_manager = KeyManager.new(@encryptor.decrypt(PasswordFile.read))

    CommandDispatcher.new(@key_manager).dispatch(ARGV)

    PasswordFile.write(@encryptor.encrypt(@key_manager.passwords_json))
  rescue RuntimeError => error_message
    puts(error_message)
  end
end

Main.new.run
