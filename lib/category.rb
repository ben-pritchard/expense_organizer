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
