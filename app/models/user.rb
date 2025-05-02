class User < ApplicationRecord
    has_many :sent_messages, class_name: 'Message', foreign_key: 'user_id', dependent: :destroy
    has_many :sent_chats, class_name: 'Chat', foreign_key: 'sender_id', dependent: :destroy
    has_many :received_chats, class_name: 'Chat', foreign_key: 'receiver_id', dependent: :destroy
    has_many :received_messages, through: :received_chats, source: :messages

    def full_name
        "#{first_name} #{last_name}".strip
      end
      
    validates :email, presence: true, uniqueness: true
end
