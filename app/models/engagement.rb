class Engagement < ApplicationRecord
  belongs_to :building
  belongs_to :user

  enum role:{
    'admin' => 0,
  }


  before_create :set_started_at

  def set_started_at
    self.started_at = self.created_at
  end
end
