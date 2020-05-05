class Building < ApplicationRecord
  has_many :engagements, :dependent => :destroy
  has_many :users, through: :engagements
  accepts_nested_attributes_for :engagements

    enum buildingtype:{
    conjunto: 0,
    edificio: 1,
    urbanizacion: 2,
  }

  #before_save :set_user
#
  #def set_user
  #  
  #  user
  #end

end
