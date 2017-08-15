class Waypoint < ApplicationRecord
  # Direct associations

  has_many   :businesses,
             :dependent => :destroy

  belongs_to :route

  # Indirect associations

  # Validations

end
