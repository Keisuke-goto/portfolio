class AddColumnToUpload < ActiveRecord::Migration[6.1]
  def change
    add_column :uploads, :title, :string
    add_column :uploads, :target, :string
  end
end
