require "json"

module Merge
  def merge(argv)
    other_passwrods_json = @encryptor.decrypt(PasswordFile.read(argv.shift))
    other_passwords = JSON.parse(other_passwrods_json)

    other_passwords.each do |key, password|
      if !@key_manager.all_keys.include?(key)
        @key_manager.add_password(key, password)
      elsif @key_manager.get_password(key) != password
        print("There is a confliction in key '#{key}', update local? (y/N): ")
        answer = STDIN.gets.chomp
        puts

        if ["Y", "y"].include?(answer)
          @key_manager.remove_password(key)
          @key_manager.add_password(key, password)
        end
      end
    end
  end
end
