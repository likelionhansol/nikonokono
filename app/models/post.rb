class Post < ActiveRecord::Base
  resourcify
  include Authority::Abilities

  has_many :replies
  belongs_to :user
end
