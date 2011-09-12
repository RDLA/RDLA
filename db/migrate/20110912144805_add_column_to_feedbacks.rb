class AddColumnToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :sprint, :integer
    add_column :feedbacks, :effort, :decimal
    add_column :feedbacks, :worker_id, :integer
  end
end
