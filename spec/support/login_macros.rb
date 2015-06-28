module LoginMacros
  def vendor_sign_in(vendor_user)
    visit vendor_root_path
    fill_in "E-mail Address", with: vendor_user.email
    fill_in "Password", with: vendor_user.password
    click_button "Log In"
  end
end
