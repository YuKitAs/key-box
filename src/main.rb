require_relative "./initialize"
require "encryptor"
require "password_file"
require "key_manager"
require "argument_parser"
require "clipboard"
require "io/console"

class Main
  def run
    @options = ArgumentParser.parse(ARGV)

    print("Please input key-box password: ")
    password = STDIN.noecho(&:gets).chomp
    puts

    @encryptor = Encryptor.new(password)

    create_password_file unless PasswordFile.exist?

    @key_manager = KeyManager.new(@encryptor.decrypt(PasswordFile.read))

    case @options[:action]
    when "add"
      add
    when "get"
      get
    when "remove"
      remove
    when "clear"
      clear
    end

    PasswordFile.write(@encryptor.encrypt(@key_manager.passwords_json))
  rescue RuntimeError => error_message
    puts(error_message)
  end

  def add
    if @options[:specify_password]
      print("Please input new password for key '#{@options[:key]}': ")
      password = STDIN.noecho(&:gets).chomp
      puts
    else
      password = @key_manager.random_password
    end
    @key_manager.add_password(@options[:key], password)

    Clipboard.copy(password)
    clear_clipboard
  end

  def get
    Clipboard.copy(@key_manager.get_password(@options[:key]))
    clear_clipboard
  end

  def remove
    @key_manager.remove_password(@options[:key])
  end

  def clear_clipboard
    print("Press enter to clear clipboard")
    gets
    Clipboard.copy("")
  end

  def create_password_file
    PasswordFile.write(@encryptor.encrypt("{}"))
  end
end

Main.new.run
