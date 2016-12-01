class ShortenedUrl < ActiveRecord::Base

  validates :short_url, :long_url, :presence => true, :uniqueness => true

  belongs_to(
    :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
  )

  has_many(
    :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    :through => :visits,
    :source => :user
  )


  def self.random_code
    code = SecureRandom.urlsafe_base64(16)
    while ShortenedUrl.exists?(:short_url => code)
      code = SecureRandom.urlsafe_base64(16)
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = ShortenedUrl.random_code
    ShortenedUrl.create!(short_url: short_url, long_url: long_url, user_id: user.id)
  end

  def num_clicks
    visits.count
    #Visit.all.select { |m| m.shortened_url_id == self.id }.count
  end

  # def num_uniques
  #   visits.select(:user_id).distinct.count
  # end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits.select(:user_id).distinct.where("visits.created_at > ?", 10.minutes.ago).count
  end

end
