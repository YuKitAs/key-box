require_relative "../initialize"

require "io/console"

require "core/key_service"
require "interactive/clipboard_accessor"

class Main
  def run(argv)
    print("Please input key-box password: ")
    key_box_password = STDIN.noecho(&:gets).chomp
    puts

    key_service = KeyService.new(key_box_password)
    argv_copy = Marshal.load(Marshal.dump(argv))
    command = argv_copy.shift

    public_send(command, key_service, argv_copy)
  rescue RuntimeError => error
    puts("[#{error.class}] #{error.message}")
  end

  def add(service, argv)
    name = argv.shift

    print("Username: ")
    username = STDIN.gets.chomp

    if argv.include?("-p")
      print("Password: ")
      password = STDIN.noecho(&:gets).chomp
      puts
    else
      password = ""
    end

    print("Extra information: ")
    extra_information = STDIN.gets.chomp

    if password == ""
      service.add_with_random_password(name, username, extra_information)
    else
      service.add(name, username, password, extra_information)
    end
  end

  def update(service, argv)
    name = argv.shift

    print("Username (not updating if left empty): ")
    username = STDIN.gets.chomp

    print("Password (not updating if left empty): ")
    password = STDIN.noecho(&:gets).chomp
    puts

    print("Extra information (not updating if left empty): ")
    extra_information = STDIN.gets.chomp

    old_key_item = service.get_one(name)
    username = old_key_item.username if username.empty?
    password = old_key_item.password if password.empty?
    extra_information = old_key_item.extra_information if extra_information.empty?

    service.update(name, username, password, extra_information)
  end

  def get(service, argv)
    copy_password_to_clipboard(service.get_one(argv.shift).password)
  end

  def list(service, argv)
    filter_string = argv.shift
    puts("Known keys:")
    service.get_all.each do |name, key|
      if filter_string.nil? || name.include?(filter_string)
        puts("  * #{name} (#{key.username}): #{key.extra_information}")
      end
    end
  end

  def merge(service, argv)
    key_file_name = argv.shift

    service.merge(key_file_name) do |name, _key|
      print("There is a confliction in key '#{name}', update local? (y/N): ")
      answer = STDIN.gets.chomp
      puts
      return ["Y", "y"].include?(answer)
    end
  end

  def remove(service, argv)
    service.remove(argv.shift)
  end

  def rename(service, argv)
    name = argv.shift
    new_name = argv.shift

    service.rename(name, new_name)
  end

  private

  def copy_password_to_clipboard(password)
    ClipboardAccessor.copy(password)
    puts("Password are stored in the clipboard for next 15 seconds")

    sleep(15)

    ClipboardAccessor.clear
    puts("Clipboard cleared")
  end
end

Main.new.run(ARGV)
