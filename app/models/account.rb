class Account < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_many :comments, through: :articles, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :first_name, presence: true
            { case_sensitive: false }
            # length: { minimum: 3, maximum: 25 }

  validates :last_name, presence: true
           { case_sensitive: false }
            # length: { minimum: 3, maximum: 25 }







  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true,
  #           uniqueness: { case_sensitive: false },
  #           length: { maximum: 105 },
  #           format: { with: VALID_EMAIL_REGEX }

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
end
