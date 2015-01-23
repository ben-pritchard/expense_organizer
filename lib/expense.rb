class Expense

  attr_reader(:id, :name, :amount, :date)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes[:name]
    @amount = attributes[:amount]
    @date = attributes[:date]
  end

  define_singleton_method(:all) do
    returned_expenses = DB.exec("SELECT * FROM expenses;")
    expenses = []
    returned_expenses.each() do |expense|
      name = expense.fetch("name")
      id = expense.fetch("id").to_i()
      amount = expense.fetch("amount")
      date = expense.fetch("date")
      expenses.push(Expense.new({:id => id, :name => name, :amount => amount, :date => date}))
    end
    expenses
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO expenses (name, amount, date) VALUES ('#{@name}', #{@amount}, '#{@date}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |other_expense|
    self.name().==(other_expense.name()) && self.id().==(other_expense.id())
  end

  define_method(:join) do |category|
    number = DB.exec("INSERT INTO expense_category (expense_id, category_id) VALUES (#{@id}, #{category.id()}) RETURNING id;")
    join_id = number.first().fetch("id").to_i()
    join_id.instance_of?(Fixnum)
  end

  define_method(:get_categories) do
    category_array = []

    categories_tied_to_expense_array = DB.exec("SELECT categories.* FROM
    expenses JOIN expense_category ON (expenses.id = expense_category.expense_id)
    JOIN categories ON (expense_category.category_id = categories.id)
    WHERE expenses.id = #{@id};")
    categories_tied_to_expense_array.each() do |category|
      name = category.fetch("name")
      category_array.push(Category.new({:name => name}))
    end
    category_array
  end

  define_singleton_method(:find) do |expense_id|
    found_expense = nil
    Expense.all().each() do |expense|
      if expense.id().==(expense_id)
        found_expense = expense
      end
    end
    found_expense
  end



  # define_singleton_method(:clear) do
  #   DB.exec("DELETE FROM expenses *;")
  # end
  #


  #
  # define_method(:list_category_names) do
  #   category_ids = []
  #   category_names = []
  #   returned_categories = DB.exec("SELECT * FROM join_table WHERE expense_id = #{self.id()};")
  #   returned_categories.each() do |category|
  #     id = category.fetch("category_id").to_i()
  #     category_ids.push(id)
  #   end
  #
  #   category_ids.each() do |id|
  #     category = DB.exec("SELECT * FROM categories WHERE id = #{id}")
  #     name = category.first().fetch("name")
  #     category_names.push(name)
  #   end
  #   category_names
  # end


end
