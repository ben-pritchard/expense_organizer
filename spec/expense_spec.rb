require('spec_helper')

describe(Expense) do
  describe(".all") do
    it("returns all expenses - returns empty at first") do
      expect(Expense.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("returns the name of the expense") do
      test_name = Expense.new({:id => 7, :name => "Burgers"})
      expect(test_name.name()).to(eq("Burgers"))
    end
  end

  describe("#id") do
    it("returns the id of the expense") do
      test_name = Expense.new({:id => 7, :name => "Burgers"})
      expect(test_name.id()).to(eq(7))
    end
  end

  describe("#amount") do
    it("returns the id of the expense") do
      test_name = Expense.new({:id => 7, :amount => 9.56})
      expect(test_name.amount()).to(eq(9.56))
    end
  end

  describe("#date") do
    it("returns the id of the expense") do
      test_name = Expense.new({:id => 7, :date => '2015-01-22'})
      expect(test_name.date()).to(eq('2015-01-22'))
    end
  end

  describe("#save") do
    it("saves the expense to the expenses table") do
      test_save = Expense.new({:name => "Burgers", :amount => 9.56, :date => '2015-01-22'})
      test_save.save()
      expect(Expense.all()).to(eq([test_save]))
    end
  end

  describe("#==") do
    it("treats two expenses with the same id and name as equal to each other") do
      test_1 = Expense.new({:name => "Burgers"})
      test_2 = Expense.new({:name => "Burgers"})
      expect(test_1).to(eq(test_2))
    end
  end

  describe("#join") do
    it("copies the unique category id and unique expense id, and puts it in the join table") do
      test_expense = Expense.new({:name => "Burgers", :amount => 9.56, :date => '2015-01-22'})
      test_expense.save()
      test_category = Category.new({:name => "Food"})
      test_category.save()
      expect(test_expense.join(test_category)).to(eq(true))
    end
  end

  describe("#get_categories") do
    it("returns all the categories associated with the expense") do
      food = Category.new({:name => "Food"})
      food.save()
      entertainment = Category.new({:name => "Entertainment"})
      entertainment.save()
      burgers_expense = Expense.new({:name => "Burgers", :amount => 5.50, :date => '2015-01-22'})
      burgers_expense.save()
      burgers_expense.join(food)
      burgers_expense.join(entertainment)
      movies_expense = Expense.new({:name => "Movies", :amount => 2.50, :date => '2015-01-22'})
      movies_expense.save()
      movies_expense.join(entertainment)
      burritos_expense = Expense.new({:name => "Burritos", :amount => 4.50, :date => '2015-01-22'})
      burritos_expense.save()
      burritos_expense.join(food)
      plays_expense = Expense.new({:name => "Plays", :amount => 7.50, :date => '2015-01-22'})
      plays_expense.save()
      plays_expense.join(entertainment)
      expect(burgers_expense.get_categories()).to(eq([food, entertainment]))
    end
  end

  describe(".find") do
    it("finds a expense based on a expense_id") do
      movies_expense = Expense.new({:name => "Movies", :amount => 2.50, :date => '2015-01-22'})
      movies_expense.save()
      burritos_expense = Expense.new({:name => "Burritos", :amount => 4.50, :date => '2015-01-22'})
      burritos_expense.save()
      expect(Expense.find(movies_expense.id())).to(eq(movies_expense))
    end
  end


  # describe(".clear") do
  #   it("clears the trains database of all expenses in the expenses table") do
  #     test_1 = Expense.new({:name => "Burgers"})
  #     test_1.save()
  #     test_2 = Expense.new({:name => "Movies"})
  #     test_2.save()
  #     Expense.clear()
  #     expect(Expense.all()).to(eq([]))
  #   end
  # end
  #


  #
  # describe("#list_category_names") do
  #   it("will return all the categories associated with a particular expense") do
  #     test_expense = Expense.new({:name => "Burgers"})
  #     test_expense.save()
  #     test_category = Category.new({:name => "Epicodus"})
  #     test_category.save()
  #     test_expense.join(test_category)
  #     test_category2 = Category.new({:name => "Times Square"})
  #     test_category2.save()
  #     test_expense.join(test_category2)
  #     test_category3 = Category.new({:name => "Guam"})
  #     test_category3.save()
  #     test_expense.join(test_category3)
  #     expect(test_expense.list_categories()).to(eq(["Epicodus", "Times Square", "Guam"]))
  #   end
  # end

end
