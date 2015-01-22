class Category

  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes[:name]
  end

  define_singleton_method(:all) do
    returned_categories = DB.exec("SELECT * FROM categories;")
    categories = []
    returned_categories.each() do |category|
      name = category.fetch("name")
      id = category.fetch("id").to_i()
      categories.push(Category.new({:id => id, :name => name}))
    end
    categories
  end

  define_method(:save) do
    duplicate = false
    Category.all().each() do |name_check|
      if self.name().==(name_check.name())
        duplicate = true
      end
    end

    if duplicate == false
      result = DB.exec("INSERT INTO categories (name) VALUES ('#{@name}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end

  end

  define_method(:==) do |other_category|
    self.name().==(other_category.name()) && self.id().==(other_category.id())
  end

  define_method(:expense_percentage) do
    category_expense = 0
    total_expense = 0
    percentage = 0.0

    category_expenses_array = DB.exec("SELECT expenses.* FROM
    categories JOIN expense_category ON (categories.id = expense_category.category_id)
    JOIN expenses ON (expense_category.expense_id = expenses.id)
    WHERE categories.id = #{@id};")
    category_expenses_array.each() do |expense|
      amount = expense.fetch("amount").to_f()
      category_expense += amount
    end

    total_expenses_array = DB.exec("SELECT * FROM expenses;")
    total_expenses_array.each() do |expense|
      amount = expense.fetch("amount").to_f()
      total_expense += amount
    end
    
    percentage = 100 * category_expense / total_expense
  end

  # define_singleton_method(:clear) do
  #   DB.exec("DELETE FROM categories *;")
  # end

#   define_singleton_method(:find) do |category_id|
#     found_category = nil
#     Category.all().each() do |category|
#       if category.id().==(category_id)
#         found_category = category
#       end
#     end
#     found_category
#   end
#
#   define_method(:join) do |expense|
#     number = DB.exec("INSERT INTO join_table (expense_id, category_id) VALUES (#{expense.id()}, #{@id}) RETURNING id;")
#     join_id = number.first().fetch("id").to_i()
#     join_id.instance_of?(Fixnum)
#   end
end
