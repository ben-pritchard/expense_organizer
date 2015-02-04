require('spec_helper')

describe(Expense) do
  it{ should have_and_belong_to_many(:categories) }
end
