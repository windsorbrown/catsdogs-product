class Vote < ActiveRecord::Base
  belongs_to :photo
  

  def self.top_cat
    top_cat = Photo.total_votes.where('photos.animal_type = ?', 'cat')
  end

  def self.top_dog
    top_dog = Photo.total_votes.where('photos.animal_type = ?', 'dog')
  end

  def self.top_dog_yesterday
    self.top_dog.where('DATE(votes.created_at) = ?', Date.yesterday).first
  end

  def self.top_cat_yesterday
    self.top_cat.where('DATE(votes.created_at) = ?', Date.yesterday).first
  end

  def self.top_dog_today
    self.top_dog.where('DATE(votes.created_at) = ?', Date.today).first
  end

  def self.top_cat_today
    self.top_cat.where('DATE(votes.created_at) = ?', Date.today).first
  end

end