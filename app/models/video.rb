class Video < ApplicationRecord
    has_many_attached :files # For video files, thumbnails, and subtitles
    validates :title, :description, :genre, :release_date, presence: true
  end