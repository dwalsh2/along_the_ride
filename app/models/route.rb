class Route < ApplicationRecord
  # Direct associations

  has_many   :waypoints,
             :dependent => :destroy

  belongs_to :user

  # Indirect associations

  # Validations

end
