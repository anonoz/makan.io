class AddStudentToCustomerUser < ActiveRecord::Migration
  def change
    add_column :customer_users, :student, :boolean, default: false
  end
end
