class Conversation < ApplicationRecord
  belongs_to :user_1, class_name: 'User'
  belongs_to :user_2, class_name: 'User'
  has_many :messages

  def name(user)
    user_1 == user ? user_2.first_name : user_1.first_name
  end

  def increment_unread(user)
    if user_1 == user
      update(unread_for_user_2: unread_for_user_2.to_i + 1)
    else
      update(unread_for_user_1: unread_for_user_2.to_i + 1)
    end
  end
end
