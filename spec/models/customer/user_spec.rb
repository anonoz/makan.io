require 'spec_helper'

describe Customer::User do
  it "is invalid without an email address" do
    emailess_user = build(:customer_user, email: nil)
    emailess_user.valid?
    expect(emailess_user.errors[:email]).to include "can't be blank"
  end

  it "is invalid without an encrypted password" do
    pwdless_user = build(:customer_user,
                         password: nil,
                         password_confirmation: nil)
    pwdless_user.valid?
    expect(pwdless_user.errors[:password]).to include "can't be blank"
  end

  it "is invalid if got same email in database" do
    create(:customer_user, email: "same@same.org")
    duplicated_user = build(:customer_user, email: "same@same.org")
    duplicated_user.valid?
    expect(duplicated_user.errors[:email]).to include "has already been taken"
  end

  it "is invalid if email is not in the right format" do
    faulty_email_user = build(:customer_user, email: "hahaha")
    faulty_email_user.valid?
    expect(faulty_email_user).to be_invalid
  end
end
