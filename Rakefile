require 'rake'
require "sinatra/activerecord/rake"
require ::File.expand_path('../config/environment', __FILE__)

class UsersImporter

  def initialize(filename=File.absolute_path('db/daily_votes.csv'))
    @filename = filename
  end

  def import
    field_names = ['photo_id', 'created_at', 'updated_at']
    puts "Importing votes from '#{@filename}'"
    failure_count = 0
    DailyVote.transaction do
      File.open(@filename).each do |line|
        data = line.chomp.split(',')
        attribute_hash = Hash[field_names.zip(data)]
        begin
          DailyVote.create!(attribute_hash)
          print '.'
        rescue ActiveRecord::UnknownAttributeError
          failure_count += 1
          print '!'
        ensure
          STDOUT.flush
        end
      end
    end
    failures = failure_count > 0 ? "(failed to create #{failure_count} user records)" : ''
    puts "\nDONE #{failures}\n\n"
  end

end


class PhotoImporter

  def initialize(filename=File.absolute_path('db/photos.csv'))
    @filename = filename
  end

  def import
    field_names = ['user_id', 'photo_link', 'created_at', 'updated_at', 'animal_type']
    puts "Importing photos from '#{@filename}'"
    failure_count = 0
    Photo.transaction do
      File.open(@filename).each do |line|
        data = line.chomp.split(',')
        attribute_hash = Hash[field_names.zip(data)]
        begin
          Photo.create!(attribute_hash)
          print '.'
        rescue ActiveRecord::UnknownAttributeError
          failure_count += 1
          print '!'
        ensure
          STDOUT.flush
        end
      end
    end
    failures = failure_count > 0 ? "(failed to create #{failure_count} user records)" : ''
    puts "\nDONE #{failures}\n\n"
  end

end



Rake::Task["db:create"].clear
Rake::Task["db:drop"].clear

# NOTE: Assumes SQLite3 DB
desc "create the database"
task "db:create" do
  touch 'db/db.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/db.sqlite3'
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc 'populate the test database with data'
task 'db:populate' do
 # AppConfig.establish_connection
 # UsersImporter.new.import
  PhotoImporter.new.import
  # Invoke your TeachersImporter here
end