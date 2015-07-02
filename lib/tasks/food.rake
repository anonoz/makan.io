namespace :food do
  desc "Add slug to food menus without it"
  task slug: :environment do
    Food::Menu.where("slug is null").find_each(&:save)
  end

end
