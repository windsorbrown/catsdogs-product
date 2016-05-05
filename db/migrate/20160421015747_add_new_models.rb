class AddNewModels < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.string :password
      t.string :animal_type
      t.timestamps NULL: false
    end
     create_table :photos do |t|
      t.belongs_to :user, index: true
      t.string :photo_link
      t.timestamps NULL: false
    end
     create_table :votes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :photos, index: true
      t.timestamps NULL: false
    end
  end
end
