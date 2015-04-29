#= require underscore-min
#= require handlebars-v3.0.1
$(document).ready ->
  
  # Unpack the data
  food_menus = JSON.parse $('#food_menus_data').text()
  food_options = JSON.parse $('#food_options_data').text()

  customizer = $('#food_customizer')

  extras = []
  amount = 0

  # In modal
  $("#food_menu_id_selector").change ->
    chosen_menu =  _.findWhere(food_menus, {id: Number $(this).val()})
    console.log chosen_menu

    extras = []
    amount = 0

    # Display the form in step 2
    customizer.html("")

    for food_option in chosen_menu.food_options
      food_option = _.findWhere food_options, {id: food_option.id}

      # Choose the right template, young man.
      template = switch food_option.kind
        when "choose_multiple" then $("#choose_multiple_form").html()
        when "choose_one" then $("#choose_one_form").html()
        when "quantities" then $("#quantities_form").html()
        else ""
      
      # Compile, render and append.
      customizer.append Handlebars.compile(template) food_option

    # Bind choose multiple
    $(".choose_multiple_input").change ->
      element = this
      if element.checked
        extras.push
          food_option_choice_id: Number this.value
          quantity: 1
          unit_amount_cents: _.findWhere(food_option.choices, {id: Number this.value}).unit_amount_cents
      else
        extras = _.reject extras, (choice)->
          console.log choice
          choice.food_option_choice_id == Number element.value

      amount = _.reduce extras, (memo, nu)->
        memo + nu.unit_amount_cents
      , 0

      $("#amount_sum").text("RM " + String(amount / 100))

    # Bind choose one
    $(".choose_one_input").change ->
      other_choices = _.findWhere(food_options, {id: Number $(this).data("food-option-id")}).choices
      other_choices_ids = _.pluck other_choices, "id"
      console.log other_choices_ids

      extras = _.reject extras, (choice)->
        console.log choice.food_option_choice_id
        other_choices_ids.indexOf(choice.food_option_choice_id) > -1

      extras.push
        food_option_choice_id: Number this.value
        quantity: 1
        unit_amount_cents: _.findWhere(other_choices, {id: Number this.value}).unit_amount_cents

      amount = _.reduce extras, (memo, nu)->
        memo + nu.unit_amount_cents
      , 0

      $("#amount_sum").text("RM " + String(amount / 100))

  # Upon submission of order item
  $("#food_menu_confirm").click ->
    customizer.html("")

    # Store the cart in session

    # Refresh the main order chit page