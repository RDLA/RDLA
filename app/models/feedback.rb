class Feedback < ActiveRecord::Base
  
  validates :status, :inclusion => { :in => %w(waiting completed in_process)}
  validates :category, :inclusion => { :in => %w(feature bug todo)}
  belongs_to :user
  scope :completed, where("status='completed'")
  scope :not_completed, where("status!='completed'")
end
