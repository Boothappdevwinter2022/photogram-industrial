class AddDefaultToPrivate < ActiveRecord::Migration[6.1]
  def change
    change_column_default(
      :users, # table name
      :private, #column name
      true #default value
    )
  end
end
