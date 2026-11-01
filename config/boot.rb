ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

# This app uses SQLite (see config/database.yml). Outside production, ignore any
# DATABASE_URL exported by the shell for other projects, which would otherwise
# take precedence over database.yml and point Rails at an unrelated database.
unless ENV["RAILS_ENV"] == "production"
  ENV.delete("DATABASE_URL")
  ENV.delete("DATABASE_REPLICA_URL")
end

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.
