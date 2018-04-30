module Remove
  def remove(argv)
    @key_manager.remove_password(argv.shift)
  end
end
