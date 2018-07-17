require "openssl"
require "digest/sha2"
require "base64"

require "core/errors/encrypting_error"

class Encryptor
  ALGORITHM = "AES-256-CBC".freeze

  def initialize(password)
    @key = Digest::SHA256.digest(password)
  end

  def encrypt(content)
    aes_cipher = OpenSSL::Cipher.new(ALGORITHM)
    aes_cipher.encrypt
    aes_cipher.key = @key
    iv = aes_cipher.iv = aes_cipher.random_iv

    return Base64.encode64(iv + aes_cipher.update(content) + aes_cipher.final)
  end

  def decrypt(content)
    content = Base64.decode64(content)
    iv = content.byteslice(0, 16)
    content = content.byteslice(16, content.bytesize - 16)

    aes_decipher = OpenSSL::Cipher.new(ALGORITHM)
    aes_decipher.decrypt
    aes_decipher.key = @key
    aes_decipher.iv = iv

    return aes_decipher.update(content) + aes_decipher.final
  rescue OpenSSL::Cipher::CipherError
    raise(EncryptingError, "Incorrect key-box password.")
  end
end
