require "utilities/password_file"
require "utilities/clipboard"

require "commands/add"
require "commands/list"
require "commands/get"
require "commands/remove"
require "commands/rename"
require "commands/merge"

class CommandDispatcher
  include Add
  include List
  include Get
  include Remove
  include Rename
  include Merge

  def initialize(key_manager, encryptor)
    @key_manager = key_manager
    @encryptor = encryptor
  end

  def dispatch(argv)
    argv_copy = Marshal.load(Marshal.dump(argv))
    command = argv_copy.shift
    public_send(command, argv_copy)
  end

  def clear_clipboard
    puts("Password are stored in the clipboard for next 15 seconds")
    sleep(15)
    Clipboard.clear
    puts("Clipboard cleared")
  end
end
