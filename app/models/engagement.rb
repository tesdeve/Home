class Engagement < ApplicationRecord
  belongs_to :building
  belongs_to :user

  enum role:{
    'admin' => 0,
    'seguridad' =>1,
  }


  before_create :set_create_attributes

  def set_create_attributes
    self.started_at = self.created_at
    self.role = 0
  end
end
