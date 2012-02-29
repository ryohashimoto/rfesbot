require 'data_mapper'
require 'dm-migrations'
load 'festival_dm.rb'

class DataManager
  def initialize
    DataMapper::Logger.new($stdout, :debug)
    DataMapper.setup(:default, 'sqlite3:db.sqlite3')
    DataMapper.finalize
    DataMapper.auto_migrate!
  end

  def run
    festival = Festival.create(
                        :name => "Example Festival"
                        )
    entry = Entry.create(
                  :festival_id => festival.id,
                  :title => "Test"
                  )
    puts festival.name
    puts festival.entries[0].title
  end
end

manager = DataManager.new
manager.run
