class AddIndexToCollectorName < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index  :collectors, :name, algorithm: :concurrently
  end
end
