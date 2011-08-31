class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :category
      t.integer :priority
      t.string :subject
      t.integer :user_id
      t.string :status
      t.text :message

      t.timestamps
    end
  end
end
