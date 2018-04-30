module List
  def list(_args)
    puts(["Known keys:", *@key_manager.all_keys].join("\n  * "))
  end
end
