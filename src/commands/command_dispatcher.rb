require "utilities/clipboard"

require "commands/add"
require "commands/list"
require "commands/get"
require "commands/remove"

class CommandDispatcher
  include Add
  include List
  include Get
  include Remove

  def initialize(key_manager)
    @key_manager = key_manager
  end

  def fetch(args)
  end

  def push(args)
  end

  def dispatch(argv)
    argv_copy = Marshal.load(Marshal.dump(argv))
    command = argv_copy.shift
    public_send(command, argv_copy)
  end

  def clear_clipboard
    print("Press enter to clear clipboard")
    STDIN.gets.chomp
    Clipboard.copy("")
  end
end
