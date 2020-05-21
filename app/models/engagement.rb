class Engagement < ApplicationRecord
  belongs_to :building
  belongs_to :user

  enum role:{
    'admin' => 0,
    'seguridad' =>1,
    'algo' => 2,
  }


validates :user_id, presence: true
  # Verifica que el Usuario solo tenga una relacion con el edificio con el mismo role.
validates :user_id, uniqueness: { scope: [:role, :building_id], 
                                message: 'Usuario ya tiene engagement con ese role. Puedes asignar otro role. '} 


  before_create :set_create_attributes

  def set_create_attributes
    self.started_at = self.created_at
    self.role ||= 0
  end

end
