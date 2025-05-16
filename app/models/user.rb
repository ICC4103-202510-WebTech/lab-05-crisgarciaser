class User < ApplicationRecord
    has_many :sent_messages, class_name: 'Message', foreign_key: 'user_id', dependent: :destroy
    has_many :sent_chats, class_name: 'Chat', foreign_key: 'sender_id', dependent: :destroy
    has_many :received_chats, class_name: 'Chat', foreign_key: 'receiver_id', dependent: :destroy
    has_many :received_messages, through: :received_chats, source: :messages

    def full_name
        "#{first_name} #{last_name}".strip
      end
      
    validates :email, 
      presence: { message: "You must have an email" },
      uniqueness: { message: "This email is already registered" },
      format: { with: URI::MailTo::EMAIL_REGEXP, message: "Email must be valid" }
    
    validates :first_name, 
      presence: { message: "First name is obligatory" }
    
    validates :last_name, 
      presence: { message: "Last name is obligatory" }
  
    before_validation :strip_name
    before_validation :titleize_name


  private

  def strip_name
    self.first_name = first_name.strip if first_name.present?
    self.last_name = last_name.strip if last_name.present?
  end

  def titleize_name
    self.first_name = first_name.titleize if first_name.present?
    self.last_name = last_name.titleize if last_name.present?
end
end
