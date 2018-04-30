module Add
  def add(argv)
    key = argv.shift

    if argv.include?("-p")
      print("Please input new password for key '#{key}': ")
      password = STDIN.noecho(&:gets).chomp
      puts
    else
      password = @key_manager.random_password
    end
    @key_manager.add_password(key, password)

    Clipboard.copy(password)

    clear_clipboard
  end
end
