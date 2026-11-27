class AddNotNullToReports < ActiveRecord::Migration[8.0]

  def change
    change_column_null :reports, :title, false
    change_column_null :reports, :body, false
  end
end
