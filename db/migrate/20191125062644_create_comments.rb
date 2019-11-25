class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.belongs_to :board
      t.string :body

      t.timestamps
    end
  end
end
