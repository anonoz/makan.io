#= require underscore-min
#= require handlebars-v3.0.1
$(document).ready ->
  
  # Unpack the data
  food_menus = JSON.parse $('#food_menus_data').text()
  food_options = JSON.parse $('#food_options_data').text()

  # Prepare handlebars

  # In modal
  $("#food_menu_id_selector").change ->
    chosen_menu =  _.findWhere food_menus, {id: Number $(this).val()}
    console.log chosen_menu

    # Display the form in step 2
    customizer = $('#food_customizer')
    customizer.html("")

    for food_option in chosen_menu.food_options
      food_option = _.findWhere food_options, {id: food_option.id}

      # Choose the right template, young man.
      template = switch food_option.kind
        when "choose_multiple" then $("#choose_multiple_form").html()
        when "choose_single" then ""
        when "quantities" then ""
        else ""
      
      # Compile, render and append.
      customizer.append Handlebars.compile(template) food_option