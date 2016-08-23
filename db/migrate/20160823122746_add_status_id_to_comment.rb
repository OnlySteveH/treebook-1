class AddStatusIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :status_id, :integer
    add_index  :comments, :status_id
  end
end
