require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get "/" do
  @expenses = Expense.all
  @categories = Category.all
  erb(:index)
end

get "/expense/:expense_id" do
  id = params.fetch("expense_id").to_i
  @found_expense = Expense.find(id)
  erb :expense
end

post "/add" do
  name = params.fetch("expense")
  amount = params.fetch("amount")
  date = params.fetch("date")
  category_name = params.fetch("category")
  @expense = Expense.create({:name => name, :amount => amount, :date => date})
  duplicate = false

  Category.all.each do |category|
    if category.name == category_name
      @expense.update({:category_ids => category.id})
      duplicate = true
      break
    end
  end

  if duplicate == false
    @category = Category.create({:name => category_name})
    @expense.update({:category_ids => @category.id})
  end
  
  redirect "/"
end

delete "/clear" do
  Category.all().each do |category|
    category.destroy
  end
  Expense.all().each do |expense|
    expense.destroy
  end
  redirect "/"
end

get "/category/:category_id" do
  id = params.fetch("category_id").to_i
  @found_category = Category.find(id)
  erb :category
end
