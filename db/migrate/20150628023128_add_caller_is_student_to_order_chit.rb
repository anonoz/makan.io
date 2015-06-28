class AddCallerIsStudentToOrderChit < ActiveRecord::Migration
  def change
    add_column :order_chits, :caller_is_student, :boolean, default: false
  end
end
