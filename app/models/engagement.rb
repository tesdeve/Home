class Engagement < ApplicationRecord
  belongs_to :building
  belongs_to :user

  enum access: {
    'admin' =>  0,
    'colaborador' => 1,

  }

  enum role: {
    'administrador' => 0, 
    'consejo' => 1,
    'contador' => 2, 
   'seguridad' => 3,
    'servicios' => 4,
  }

#@users = User.order('created_at DESC')
#
#rder(StatusChange.arel_table['created_at'].desc)

validates :user_id, presence: true
  # Verifica que el Usuario solo tenga una relacion con el edificio con el mismo role.
validates :user_id, uniqueness: { scope: [:role, :building_id], 
                                message: 'Usuario ya tiene engagement con ese role. Puedes asignar otro role. '} 


  before_create :set_create_attributes

  def set_create_attributes
    self.started_at = self.created_at
    self.access ||= 0
    self.role ||= 0
    #self.creator ||= current_user.id
  end

end
