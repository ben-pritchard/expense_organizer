require('spec_helper')

describe(Category) do
  describe(".all") do
    it("returns all categories - returns empty at first") do
      expect(Category.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("returns the name of the category") do
      test_name = Category.new({:id => 7, :name => "Food"})
      expect(test_name.name()).to(eq("Food"))
    end
  end

  describe("#id") do
    it("returns the id of the category") do
      test_name = Category.new({:id => 7, :name => "Food"})
      expect(test_name.id()).to(eq(7))
    end
  end

  describe("#save") do
    it("saves the category to the categories table") do
      test_save = Category.new({:name => "Food"})
      test_save.save()
      expect(Category.all()).to(eq([test_save]))
    end
  end

  describe("#save") do
    it("only saves if the category to be saved isn't already in the list") do
      test_1 = Category.new({:name => "Food"})
      test_1.save()
      test_2 = Category.new({:name => "Food"})
      test_2.save()
      expect(Category.all()).to(eq([test_1]))
    end
  end

  describe("#==") do
    it("treats two category with the same id and name as equal to each other") do
      test_1 = Category.new({:name => "Clothing"})
      test_2 = Category.new({:name => "Clothing"})
      expect(test_1).to(eq(test_2))
    end
  end
#
#   describe(".clear") do
#     it("clears the trains database of all categories in the categories table") do
#       test_1 = Category.new({:name => "Epicodus"})
#       test_1.save()
#       test_2 = Category.new({:name => "Times Square"})
#       test_2.save()
#       Category.clear()
#       expect(Category.all()).to(eq([]))
#     end
#   end
#
#   describe(".find") do
#     it("finds a category based on a category_id") do
#       test_1 = Category.new({:name => "Epicodus"})
#       test_1.save()
#       test_2 = Category.new({:name => "Times Square"})
#       test_2.save()
#       expect(Category.find(test_1.id())).to(eq(test_1))
#     end
#   end
#
  # describe("#join") do
  #   it("copies the unique category id and unique expense id, and puts it in the join table") do
  #     test_expense = Expense.new({:name => "Burgers"})
  #     test_expense.save()
  #     test_category = Category.new({:name => "Food"})
  #     test_category.save()
  #     expect(test_category.join(test_expense)).to(eq(true))
  #   end
  # end
end
