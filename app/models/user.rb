class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable,:lockable, :timeoutable, :trackable 

  has_many :engagements, :dependent => :destroy
  has_many :buildings, through: :engagements

  has_many :invitations, :class_name => "Invite", :foreign_key => 'recipient_id'
  has_many :sent_invites, :class_name => "Invite", :foreign_key => 'sender_id'

  enum role_type:{
    'admin' => 0,
    'user' => 1,
    'manege' => 2,
  }

  def username
    self.email.split('@')[0].titleize
  end
  
end


#has_one :contactinfo, as: :contactable
#accepts_nested_attributes_for :contactinfo, allow_destroy: true#