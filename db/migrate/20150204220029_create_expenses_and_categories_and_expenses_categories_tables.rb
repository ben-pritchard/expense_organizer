class CreateExpensesAndCategoriesAndExpensesCategoriesTables < ActiveRecord::Migration
  def change
    create_table(:expenses) do |t|
      t.column(:name, :string)
      t.column(:amount, :float)

      t.timestamps
    end

    create_table(:categories) do |t|
      t.column(:name, :string)
    end

    create_table(:categories_expenses) do |t|
      t.column(:category_id, :integer)
      t.column(:expense_id, :integer)
    end

  end
end
