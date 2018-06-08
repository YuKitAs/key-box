module Rename
  def rename(argv)
    old_key = argv.shift
    new_key = argv.shift

    if @key_manager.all_keys.include?(new_key)
      print("Key '#{new_key}' already exists, overwrite? (y/N): ")
      answer = STDIN.gets.chomp
      puts

      return unless ["Y", "y"].include?(answer)
    end

    password = @key_manager.get_password(old_key)
    @key_manager.remove_password(old_key)
    @key_manager.add_password(new_key, password)
  end
end
