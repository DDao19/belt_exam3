class Organization < ActiveRecord::Base
  validates :name, presence: true, length:{ minimum: 5 }
  validates :description, presence: true, length:{ minimum: 10 }

  belongs_to :user
  has_many :memberships
  has_many :users, through: :memberships  
end
