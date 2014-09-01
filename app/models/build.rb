class Build < ActiveRecord::Base
  belongs_to :repository
  has_many :jobs
end
