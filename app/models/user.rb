class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable,
  devise :omniauthable, omniauth_providers: %i[linkedin]
  
  has_many :schedules

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.linkedin_data'] && session['devise.linkedin_data']['extra']['raw_info']
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
      .from('schedules AS other_schedules')
      .joins('INNER JOIN schedules self_schedules ON self_schedules.availability = other_schedules.availability AND self_schedules.location = other_schedules.location AND self_schedules.user_id <> other_schedules.user_id')
      .order('other_schedules.availability, other_schedules.location')
      .where.not('other_schedules.user_id': id)
      .where('other_schedules.gender': gender)
      .where('other_schedules.availability >= ?', Date.today)
      .where('NOT EXISTS(SELECT 1 FROM removed_matches WHERE removed_matches.schedule_1_id = self_schedules.id AND removed_matches.schedule_2_id = other_schedules.id)')
      .where('NOT EXISTS(SELECT 1 FROM removed_matches WHERE removed_matches.schedule_1_id = other_schedules.id AND removed_matches.schedule_2_id = self_schedules.id)')
      .select('other_schedules.*, self_schedules.id AS self_schedule_id')
  end

  def unread
    Conversation.where(user_1: self).pluck(:unread_for_user_1).compact.sum +
      Conversation.where(user_2: self).pluck(:unread_for_user_2).compact.sum
  end
end
