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

validates :user_id, presence: true

# Ensure engagement role uniqueness ESTO ES IMPORTANTE COMENTADO POR TESTEO
#validates :user_id, uniqueness: { scope: [:role, :building_id], 
                             #   message: 'Usuario ya tiene engagement con ese role. Puedes asignar otro role. '} 


  before_create :set_create_attributes
  def set_create_attributes
    self.started_at = self.created_at
    self.access ||= 0
    self.role ||= 0
    #self.creator = current_user.id
  end

  after_create :set_creator_when_user_invited
  def set_creator_when_user_invited
    if self.creator == nil
      user = User.find(self.user_id)
      invites = Invite.where(building_id: self.building_id, email: user.email)
      il = invites.last
      creatorInv = il.sender_id
      self.creator = creatorInv
      self.save
    end
  end

end

