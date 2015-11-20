class User < ActiveRecord::Base
    attr_reader :password

    validates :username, :session_token, presence: true, uniqueness: true
    validates :password, length: { minimum: 6, allow_nil: true }
    validates :password_digest, presence: true
    after_initialize :ensure_session_token

    has_many :subs,
      foreign_key: :moderator_id,
      primary_key: :id,
      class_name: 'Sub'

    has_many :manageable_posts,
      through: :subs,
      source: :posts

    has_many :posts,
      foreign_key: :author_id,
      primary_key: :id,
      class_name: 'Post'

    def password=(password)
      @password = password
      self.password_digest = BCrypt::Password.create(password)
    end

    def self.find_by_credentials(username, password)
      user = User.find_by(username: username)

      (user && user.is_password?(password)) ? user : nil
    end

    def is_password?(password)
      pd = BCrypt::Password.new(self.password_digest)
      pd.is_password?(password)
    end

    def ensure_session_token
      self.session_token ||= User.generate_session_token
    end

    def reset_session_token
      self.session_token = User.generate_session_token
      self.save!
      self.session_token
    end

    def self.generate_session_token
      SecureRandom.urlsafe_base64(16)
    end

end
