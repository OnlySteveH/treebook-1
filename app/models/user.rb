class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  validates_presence_of   :avatar
  validates_integrity_of  :avatar
  validates_processing_of :avatar


  has_many :statuses
  has_many :users

  validates :first_name,    presence: true
  validates :last_name,     presence: true

  validates :profile_name,  presence: true,
                            uniqueness: true,
                            format: {
                                    with: /\A[a-zA-Z0-9_-]+\z/,

                                    message: "Must be formatted correctly." }

  def full_name
    first_name + " " + last_name
  end

  def gravatar_url
  stripped_email =  email.strip
  end
end
