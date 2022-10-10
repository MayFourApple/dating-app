class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable,
  devise :omniauthable, omniauth_providers: %i[linkedin]

  has_many :schedules

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.linkedin_data'] && sesion['devise.linkedin_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.picture_url = auth.info.picture_url
    end
  end

  def matches
    Schedule
      .order(:availability, :location)
      .where.not(user: self)
      .where(gender: gender)
      .where('EXISTS(SELECT * FROM schedules s1 WHERE s1.availability = schedules.availability AND s1.location = schedules.location AND s1.user_id <> schedules.user_id)')
  end

  def unread
    Conversation.where(user_1: self).pluck(:unread_for_user_1).compact.sum +
      Conversation.where(user_2: self).pluck(:unread_for_user_2).compact.sum
  end
end
