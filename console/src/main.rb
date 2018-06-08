require_relative "./initialize"

require "utilities/clipboard"
require "utilities/encryptor"
require "utilities/key_manager"
require "utilities/password_file"

require "commands/command_dispatcher"

require "commands/add"
require "commands/list"
require "commands/get"
require "commands/remove"
require "commands/rename"
require "commands/merge"

require "io/console"

class Main
  include Add
  include List
  include Get
  include Remove
  include Rename
  include Merge

  def run
    print("Please input key-box password: ")
    password = STDIN.noecho(&:gets).chomp
    puts

    @encryptor = Encryptor.new(password)
    create_password_file unless PasswordFile.exist?
    @key_manager = KeyManager.new(@encryptor.decrypt(PasswordFile.read))

    CommandDispatcher.new(@key_manager, @encryptor).dispatch(ARGV)

    PasswordFile.write(@encryptor.encrypt(@key_manager.passwords_json))
  rescue RuntimeError => error_message
    puts(error_message)
  end

  private

  def create_password_file
    PasswordFile.write(@encryptor.encrypt("{}"))
  end
end

Main.new.run
