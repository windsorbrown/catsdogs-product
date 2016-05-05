class AddDailyVotes < ActiveRecord::Migration
  def change
      create_table :daily_votes do |t|
        t.belongs_to :photo, index: true
        t.timestamps NULL: false
    end

  end
end
