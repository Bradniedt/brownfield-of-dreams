class AddGithubnameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :githubname, :string
  end
end
