class Bookmark < ApplicationRecord
  belongs_to :user

  validates :url, presence: true,
                  format: { with: Regexp.new(URI::regexp(%w(http https))) },
                  uniqueness: { scope: :user_id }

  def link_info
    LinkThumbnailer.generate(url)
  end

  def self.search(search)
    where('url LIKE ?', "%#{search}%")
  end

  def short_url
    url.slice((url.index('/') + 2)..-1)
  end
end
