class Member < ActiveRecord::Base
  has_many :ads, dependent: :destroy
  has_many :comments

  attr_accessor :remember_token, :reset_token

  before_save :email_downcase #, if: :without_provider?

  validates :login, :full_name, presence: true
  validates :email, :address, :city, :state, :country, :zip, presence: true, 
                  if: :without_provider?
  validates :login, length: { in: 2..20 }, uniqueness: { case_sensitive: false }
  validates_presence_of :birthday, message: "should have format 'day/month/year'",
                 if: :without_provider?
  validates :email, presence: true, length: { maximum: 255 },
                               format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                               uniqueness: { case_sensitive: false },
                               if: :without_provider?

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :password_confirmation, presence: true, if: :without_provider?

  enum role: { user: 1, moderator: 2, admin: 3 }

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                                             BCrypt::Engine.cost
    BCrypt::Password.create(token, cost: cost)
  end

  def remember
    self.remember_token = Member.new_token
    update_attribute(:remember_digest, Member.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?    
    BCrypt::Password.new(digest).is_password?(token)
  end

  def create_reset_digest
    self.reset_token = Member.new_token
    update_columns(reset_digest: Member.digest(reset_token),
                              reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    MemberMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 15.minutes.ago
  end

  def self.find_member_with_omniauth(auth)
    login = auth["info"]["name"]
    where(provider: auth["provider"], uid: auth["uid"]).first || 
               find_by(login: login) || create_member_with_omniauth(auth)
  end    

  def self.create_member_with_omniauth(auth)
    create! do |member|
      member.provider = auth.provider
      member.uid = auth.uid
      member.login = auth.info.name
      member.full_name = auth.info.name
      member.email = auth.info.email
      member.password = ('a'..'z').to_a.shuffle[0..7].join
    end
  end
  
  private
    def email_downcase
      if self.email
        self.email = email.downcase
      end
    end

    def without_provider?
      self.provider.nil?
    end

end
