require "open3"

class Clipboard
  def self.copy(content)
    if !(/linux/ =~ RUBY_PLATFORM).nil?
      Open3.popen3("xclip -selection clipboard"){|input, _, _| input << content}
    elsif !(/mac/ =~ RUBY_PLATFORM).nil?
      puts(`echo #{content}`)
    end
  end
end
