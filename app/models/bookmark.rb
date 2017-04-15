class Bookmark < ApplicationRecord
  belongs_to :user
  after_create :save_screen

  validates :url, presence: true,
                  format: { with: Regexp.new(URI::regexp(%w(http https))) },
                  uniqueness: { scope: :user_id }

  def self.search(search)
    where('url LIKE ?', "%#{search}%")
  end

  def short_url
    url.slice((url.index('/') + 2)..-1)
  end

  private

  def save_screen
    ws = Webshot::Screenshot.instance
    screenshot = ws.capture url, "#{url_image_title}.png", width: 163
    uploader = Cloudinary::Uploader.upload(screenshot.path)
    update(image_url: uploader['url'])
  end

  def url_image_title
    short_url.slice(0..short_url.index('.') - 1)
  end
end
