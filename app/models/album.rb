class Album < ActiveRecord::Base
  attr_accessible :artist, :genre, :number_of_discs, :number_of_tracks, :title, :year

  validates_presence_of :title
end
