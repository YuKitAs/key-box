require "open3"

class ClipboardAccessor
  def self.copy(content)
    if !(/linux/ =~ RUBY_PLATFORM).nil?
      Open3.popen3("xclip -selection clipboard"){|input, _, _| input << content}
    elsif !(/darwin/ =~ RUBY_PLATFORM).nil?
      `printf '%s' '#{content}' | pbcopy`
    end
  end

  def self.clear
    copy("")
  end
end
