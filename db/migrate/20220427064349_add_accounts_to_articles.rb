class AddAccountsToArticles < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :account
    add_reference :comments, :account
  end
end
