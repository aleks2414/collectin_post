class Post < ActiveRecord::Base
  belongs_to :user

    serialize :photo   # Store images array as YAML in the database

    validates :url, presence: true, :format => URI::regexp(%w(http https))

    before_save :scrape_with_grabbit

    acts_as_taggable
    is_impressionable
    acts_as_votable
    

    paginates_per 12

    # mount_uploader :photo, PhotoUploader

    private

    def scrape_with_grabbit

        # I highly recommend passing the following call off to a Resque worker, or Delayed Job queue.
        # The reason is that Grabbit will attempt to access the remote URL. If there is a network problem,
        # or the remote URL is unavailable, the following line could hang up your Rails process.

        data = Grabbit.url(url)

        if data
            self.title = data.title
            self.description = data.description
            self.photo = data.images.first
        end

    end
end

# == Schema Information
#
# Table name: scrapes
#
#  id          :integer          not null, primary key
#  url         :string(255)
#  title       :string(255)
#  description :text
#  images      :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null

