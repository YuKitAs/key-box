class FileAccessor
  def initialize(key_file_path)
    @key_file_path = key_file_path
  end

  def exist?
    return File.exist?(@key_file_path)
  end

  def write(content)
    File.open(@key_file_path, "w"){|file| file.write(content)}
  end

  def read
    return File.read(@key_file_path)
  end
end
