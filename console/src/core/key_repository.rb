require "json"
require "ostruct"

require "core/encryptor"
require "core/file_accessor"
require "core/errors/key_management_error"

class KeyRepository
  DEFAULT_KEY_FILE_PATH = File.join(File.expand_path("~"), ".shoppinglist2").freeze

  def initialize(key_box_password, key_file_path = DEFAULT_KEY_FILE_PATH)
    @encryptor = Encryptor.new(key_box_password)
    @file_accessor = FileAccessor.new(key_file_path)

    unless @file_accessor.exist?
      @file_accessor.write(@encryptor.encrypt("{}"))
    end

    @existing_keys = JSON.parse(@encryptor.decrypt(@file_accessor.read))
  end

  def add_key(name, username, new_password, extra_information)
    if @existing_keys.has_key?(name)
      raise(KeyManagementError, "Key with name '#{name}' already exists.")
    end

    @existing_keys[name] = { username: username, password: new_password, extra_information: extra_information }

    sync_keys
  end

  def remove_key(name)
    unless @existing_keys.has_key?(name)
      raise(KeyManagementError, "Key with name '#{name}' does not exist.")
    end

    @existing_keys.delete(name)

    sync_keys
  end

  def get_key(name)
    unless @existing_keys.has_key?(name)
      raise(KeyManagementError, "Key with name '#{name}' does not exist.")
    end

    return OpenStruct.new(@existing_keys[name])
  end

  def list_all_keys
    all_keys = {}
    @existing_keys.keys.sort.each{|name| all_keys[name] = OpenStruct.new(@existing_keys[name])}
    return all_keys
  end

  private

  def sync_keys
    @file_accessor.write(@encryptor.encrypt(JSON.generate(@existing_keys)))
    @existing_keys = JSON.parse(@encryptor.decrypt(@file_accessor.read))
  end
end
