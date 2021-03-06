class Album < ActiveRecord::Base
  attr_accessible :artist, :genre, :number_of_discs, :number_of_tracks, :title, :year, :cover

  validates_presence_of :title

  mount_uploader :cover, CoverUploader

  def self.search(query, user=nil)
    return unless query.present?
    (user.try(:albums) || self).all.select do |album|
      album.attributes.values.map{|a|a.to_s.upcase}.join(' ').include? query.upcase
    end
  end

end
