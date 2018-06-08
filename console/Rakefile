task(default: [:test])

task :test do
  sh "rspec spec"
  sh "rubocop"
end

task :clear do
  sh "rm -rf ~/.shoppinglist"
end
