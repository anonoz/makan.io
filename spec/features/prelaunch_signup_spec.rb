require 'spec_helper'

feature "Prelaunch Signup Page" do
  background do
    visit root_path
  end

  scenario "can see makan.io masthead", js: true do
    expect(page).to have_content "makan.io"
  end

  scenario "can see the big ass slogan in yo face", js: true do
    expect(page).to have_content "All-New"
  end

  scenario "contact us link has my e-mail", js: true do
    expect(page).to have_xpath("//a[contains(@href,email)]")
  end

end
