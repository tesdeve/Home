class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  enum role:{
    'admin' => 0,
    'self' => 1,
    'manege' => 2,
  }

  has_many :engagements, :dependent => :destroy
  has_many :buildings, through: :engagements
  
end


#has_one :contactinfo, as: :contactable
#accepts_nested_attributes_for :contactinfo, allow_destroy: true#