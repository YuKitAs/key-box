require "json"
require "securerandom"

class KeyManager
  def initialize(existing_passwords_json)
    @existing_passwords = JSON.parse(existing_passwords_json)
  end

  def random_password
    return SecureRandom.urlsafe_base64
  end

  def add_password(key, password)
    if @existing_passwords.has_key?(key)
      raise(RuntimeError, "Error: key '#{key}' exists already.")
    end

    @existing_passwords[key] = password
  end

  def remove_password(key)
    unless @existing_passwords.has_key?(key)
      raise(RuntimeError, "Error: key '#{key}' does not exist.")
    end

    @existing_passwords.delete(key)
  end

  def get_password(key)
    unless @existing_passwords.has_key?(key)
      raise(RuntimeError, "Error: key '#{key}' does not exist.")
    end

    return @existing_passwords[key]
  end

  def passwords_json
    return JSON.generate(@existing_passwords)
  end
end
