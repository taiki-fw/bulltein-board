class AddBodyToBoards < ActiveRecord::Migration[5.2]
  def change
    add_column :boards, :body, :text
  end
end
