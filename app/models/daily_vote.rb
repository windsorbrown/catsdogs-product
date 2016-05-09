class DailyVote < ActiveRecord::Base
  
  belongs_to :photo


  class << self

    def winner_of_day(days_ago)
      if winning_photo_array = DailyVote.where('DATE(created_at) = ?', Date.today - days_ago).group('photo_id').count.max_by{|k,v| v}
        Photo.find_by id: winning_photo_array[0]
      else
        Photo.find_by id: 2
      end
    end

    def dog_votes_today
      DailyVote.where('DATE(daily_votes.created_at) = ?', Date.today).joins('JOIN photos ON daily_votes.photo_id = photos.id')\
      .where("animal_type = ?", 'dog')
    end

    def cat_votes_today
      DailyVote.where('DATE(daily_votes.created_at) = ?', Date.today).joins('JOIN photos ON daily_votes.photo_id = photos.id')\
      .where("animal_type = ?", 'cat')
    end

    def total_daily_vote_count
      dog_votes_today.count + cat_votes_today.count
    end

    def dogometer_score
      if dog_votes_today.empty?
        return 0
      else
        ((dog_votes_today.count.to_f / total_daily_vote_count.to_f) * 10000).round
      end
    end

    def catometer_score
      if cat_votes_today.empty?
        return 0
      else
        ((cat_votes_today.count.to_f / total_daily_vote_count.to_f) * 10000).round
      end
    end

  end

end