class AddFeedbackTable < ActiveRecord::Migration
  def up
    create_table :feedbacks do |t|
      t.text :message, :null => false
      t.integer :user_id
      t.timestamps
    end
  end

  def down
    drop_table :feedbacks
  end
end
