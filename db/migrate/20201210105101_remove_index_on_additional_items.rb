class RemoveIndexOnAdditionalItems < ActiveRecord::Migration[6.0]
  def change
    remove_index :additional_items, :item_id
  end
end
