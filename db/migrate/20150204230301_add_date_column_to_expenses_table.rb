class AddDateColumnToExpensesTable < ActiveRecord::Migration
  def change
    add_column(:expenses, :date, :datetime)
  end
end
