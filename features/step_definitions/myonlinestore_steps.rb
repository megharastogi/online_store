Given /^I am logged in as Admin$/ do
  @account = Factory.create(:account)
  @admin = Factory.create(:admin, :account => @account)
  visit("/session/new")
  fill_in("email", :with => @account.email)
  fill_in("password", :with => 'pass123')
  click_button("Log In")
end