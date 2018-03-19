class PasswordFile
  FILE_PATH = File.join(File.expand_path("~"), ".shoppinglist").freeze

  def self.exist?(path = FILE_PATH)
    return File.exist?(path)
  end

  def self.write(content, path = FILE_PATH)
    File.open(path, "w"){|file| file.write(content)}
  end

  def self.read(path = FILE_PATH)
    unless exist?(path)
      raise(RuntimeError, "Error: password file does not exist")
    end
    return File.read(path)
  end
end
