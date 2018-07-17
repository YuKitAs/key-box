require "securerandom"

require "core/key_repository"

class KeyService
  def initialize(key_box_password)
    @key_repository = KeyRepository.new(key_box_password)
  end

  def add(name, username, new_password, extra_information)
    @key_repository.add_key(name, username, new_password, extra_information)
  end

  def add_with_random_password(name, username, extra_information)
    add(name, username, SecureRandom.urlsafe_base64, extra_information)
  end

  def update(name, username, password, extra_information)
    remove(name)
    add(name, username, password, extra_information)
  end

  def remove(name)
    @key_repository.remove_key(name)
  end

  def get_one(name)
    return @key_repository.get_key(name)
  end

  def get_all
    return @key_repository.list_all_keys
  end

  def merge(key_file_path)
    another_key_repository = KeyRepository.new(key_box_password, key_file_path)

    another_key_repository.list_all_keys.each do |name, key|
      if !get_all.include?(name)
        add(name, key.username, key.password, key.extra_information)
      elsif get_one(name).password != key.password
        if yield(name, key)
          update(name, key.username, key.password, key.extra_information)
        end
      end
    end
  end

  def rename(name, new_name)
    key = get_one(name)
    add(new_name, key.username, key.password, key.extra_information)
    remove(name)
  end
end
