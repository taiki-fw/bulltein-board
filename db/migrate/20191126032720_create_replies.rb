class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.string :body
      t.belongs_to :comment

      t.timestamps
    end
  end
end
