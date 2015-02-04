require("bundler/setup")
also_reload('./lib/**/*.rb')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get("/") do
  @expenses = Expense.all()
  @categories = Category.all()
  erb(:index)
end

get("/expense/:expense_id") do
  id = params.fetch("expense_id").to_i()
  @found_expense = Expense.find(id)
  @categories_of_expense = @found_expense.get_categories()
  erb(:expense)
end

post("/add") do
  name = params.fetch("expense")
  amount = params.fetch("amount")
  date = params.fetch("date")
  category_name = params.fetch("category")
  @category = Category.new({:name => category_name})
  @category.save()
  @expense = Expense.new({:name => name, :amount => amount, :date => date})
  @expense.save()
  @expense.join(@category)
  redirect("/")
end
