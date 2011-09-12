class Feedback < ActiveRecord::Base
  
  validates :status, :inclusion => { :in => %w(waiting completed in_process)}
  validates :category, :inclusion => { :in => %w(feature bug todo)}
  belongs_to :user
  belongs_to :user, :foreign_key => "worker"
  scope :completed, where("status='completed'")
  scope :waiting, where("status='waiting'")
  scope :in_process, where("status='in_process'")
end
