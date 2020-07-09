class Building < ApplicationRecord
  has_many :engagements, :dependent => :destroy
  has_many :users, through: :engagements
  accepts_nested_attributes_for :engagements

  has_many :invites

    enum buildingtype:{
    conjunto: 0,
    edificio: 1,
    urbanizacion: 2,
  }
  
validates :name, presence: true

end
