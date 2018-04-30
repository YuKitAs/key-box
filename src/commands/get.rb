module Get
  def get(argv)
    Clipboard.copy(@key_manager.get_password(argv.shift))

    clear_clipboard
  end
end
