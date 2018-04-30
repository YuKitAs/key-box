require_relative "./initialize"

require "utilities/clipboard"
require "utilities/encryptor"
require "utilities/key_manager"
require "utilities/password_file"

require "commands/add"
require "commands/list"
require "commands/get"
require "commands/remove"
require "commands/merge"

require "io/console"

class Main
  include Add
  include List
  include Get
  include Remove
  include Merge

  def run
    print("Please input key-box password: ")
    password = STDIN.noecho(&:gets).chomp
    puts

    @encryptor = Encryptor.new(password)
    create_password_file unless PasswordFile.exist?
    @key_manager = KeyManager.new(@encryptor.decrypt(PasswordFile.read))

    dispatch(ARGV)

    PasswordFile.write(@encryptor.encrypt(@key_manager.passwords_json))
  rescue RuntimeError => error_message
    puts(error_message)
  end

  private

  def create_password_file
    PasswordFile.write(@encryptor.encrypt("{}"))
  end

  def dispatch(argv)
    argv_copy = Marshal.load(Marshal.dump(argv))
    command = argv_copy.shift
    public_send(command, argv_copy)
  end

  def clear_clipboard
    print("Press enter to clear clipboard")
    STDIN.gets.chomp
    Clipboard.copy("")
  end
end

Main.new.run
