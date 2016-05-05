class NewColumnForVotes < ActiveRecord::Migration
  def change
     add_column :votes, :vote_type, :integer ,:null => false, :default => 0
  end
end
