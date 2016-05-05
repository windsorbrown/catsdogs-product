class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  has_many :daily_votes

  
  def upvotes(date = nil)
    q = votes.where(vote_type: 1)
    if date
      q.where(created_at: date)
    end
    q.count
  end

  def downvotes(date = nil)
    q = votes.where(vote_type: -1)
    if date
      q.where(created_at: date)
    end
    q.count
  end
  
  
  def self.total_votes
    photos = joins(:votes)
      .select('photos.*, SUM(votes.vote_type) AS vote_sum')
      .group('photos.id')
      .order('vote_sum DESC')
  end

  def self.total_votes_today
      total_votes.where('DATE(votes.created_at) = ?', Date.today)
  end
end


# def self.by_votes_for_date(date, vote_type = nil)
#     photos = joins(:votes)
#       .select('photos.*, SUM(votes.vote_type) AS vote_sum')
#       .group('photos.id')
#       .where('votes.created_at = ?', date)
#       .order('vote_sum DESC')
#     if vote_type
#       photos.where('votes.vote_type = ?', vote_type)
#     end
#     photos
#   end