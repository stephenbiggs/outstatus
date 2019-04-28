class Desk < ApplicationRecord

  belongs_to :user, optional: true
  
end
