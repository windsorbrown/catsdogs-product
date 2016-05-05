class ChangePhotosName < ActiveRecord::Migration
  def change
    drop_table :votes
     create_table :votes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :photo, index: true
      t.timestamps NULL: false
    end
  end
end
