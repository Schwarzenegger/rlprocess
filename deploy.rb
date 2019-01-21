# -----------------------------------------------------
# Ruby/Rails Heroku Deployment Script
# @author Daniel Berkompas
#
# After downloading, run `ruby deploy.rb --help` to
# get usage instructions.
#
# MIT License
# -----------------------------------------------------
require 'optparse'

# Set default options
options = {
  migrations: true,
  branch: "master",
  remote: "heroku"
}

# Interpret passed in options
OptionParser.new do |opts|
  # Usage instructions.  Access with the --help flag
  opts.banner = "Usage: ruby deploy.rb [options]"

  # Optional Argument
  # Determines whether to run migrations or not. Default: migrations run.
  opts.on("-n", "--no-migrations", "Don't run `heroku run rake db:migrate`. They run by default.") do |v|
    options[:migrations] = v.nil?
  end

  # Optional Argument
  # Determines which branch to push to Heroku. Default: master
  opts.on("--branch [BRANCH]", String, "Select a branch to push. e.g. '-b feature_something' Default: master") do |v|
    options[:branch] = v unless v.nil?
  end

  # Optional Argument
  # Determines which remote to push to.  Default: production
  opts.on("--remote [REMOTE]", String, "Set the remote to push to. e.g. '-r staging' Default: production") do |v|
    options[:remote] = v unless v.nil?
  end
end.parse!

# Deploy Code
puts "----------------------------------------------------"
puts "1. Deploying Code to Heroku"
puts "----------------------------------------------------"
puts "Branch: #{options[:branch].upcase}"
puts "Remote: #{options[:remote].upcase}"
puts "Run Migrations? #{options[:migrations].to_s.upcase}"
puts "----------------------------------------------------"

system "git push -f #{options[:remote]} #{options[:branch]}:master"

# Run migrations
if options[:migrations] == true
  puts "----------------------------------------------------"
  puts "2. Running Migrations"
  puts "----------------------------------------------------"

  puts "Putting site in maintenance mode..."
  system "heroku maintenance:on --remote #{options[:remote]}"

  puts "Running migrations..."
  system "heroku run rake db:migrate --remote #{options[:remote]}"

  puts "Taking site out of maintenance mode..."
  system "heroku maintenance:off --remote #{options[:remote]}"
end

puts "Done!  Your code is now live."
