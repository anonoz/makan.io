#= require underscore-min
#= require handlebars-v3.0.1
$(document).ready ->

  window.cart = []
  
  # Unpack the data
  food_menus = JSON.parse $('#food_menus_data').text()
  food_options = JSON.parse $('#food_options_data').text()

  customizer = $('#food_customizer')

  $("a[data-reveal-id=add_item_modal]").click ->
    food_menu_id_selector = $("#food_menu_id_selector")
    food_menu_id_selector.val("")
    food_menu_id_selector.change()

  # In modal
  $("#food_menu_id_selector").change ->
    chosen_menu =  _.findWhere(food_menus, {id: Number $(this).val()})
    console.log chosen_menu

    # RESET
    extras = []
    base_amount = chosen_menu && chosen_menu.base_price_cents || 0
    extras_amount = 0
    $("#amount_sum").text("RM " + String((base_amount + extras_amount) / 100))

    # Display the form in step 2
    customizer.html("")

    # If no food chosen
    chosen_menu || customizer.html("<p>Choose some food first.</p>")

    # Only do so if got food chosen to avoid undefined error
    chosen_menu && for food_option in chosen_menu.food_options
      food_option = _.findWhere food_options, {id: food_option.id}

      # Choose the right template, young man.
      template = switch food_option.kind
        when "choose_multiple" then $("#choose_multiple_form").html()
        when "choose_one" then $("#choose_one_form").html()
        when "quantities" then $("#quantities_form").html()
      
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

      extras_amount = _.reduce extras, (memo, nu)->
        memo + nu.unit_amount_cents
      , 0

      $("#amount_sum").text "RM #{ String((base_amount + extras_amount) / 100) }"
      console.log extras

    # Bind choose one
    $(".choose_one_input").change ->
      other_choices = _.findWhere(food_options, {id: Number $(this).data("food-option-id")}).choices
      other_choices_ids = _.pluck other_choices, "id"
      console.log other_choices_ids

      # Delete all other choices in the same namespace
      extras = _.reject extras, (choice)->
        console.log choice.food_option_choice_id
        other_choices_ids.indexOf(choice.food_option_choice_id) > -1

      extras.push
        food_option_choice_id: Number this.value
        quantity: 1
        unit_amount_cents: _.findWhere(other_choices, {id: Number this.value}).unit_amount_cents

      extras_amount = _.reduce extras, (memo, nu)->
        memo + nu.unit_amount_cents
      , 0

      $("#amount_sum").text "RM #{ String((base_amount + extras_amount) / 100) }"
      console.log extras

    # Bind quantities
    $(".quantities_input").change ->
      quantity = Number this.value
      choice_id = Number $(this).data("food-option-choice-id")

      # Delete first if exist
      extras = _.reject extras, (choice)->
        choice.food_option_choice_id == choice_id

      # TODO: Too hackish to my liking
      console.log choices = _.flatten _.pluck food_options, "choices"

      # Add it back
      if quantity > 0
        extras.push
          food_option_choice_id: choice_id
          quantity: quantity
          unit_amount_cents: _.findWhere(choices, {id: choice_id}).unit_amount_cents * quantity
      
      extras_amount = _.reduce extras, (memo, nu)->
        memo + nu.unit_amount_cents
      , 0

      $("#amount_sum").text "RM #{ String((base_amount + extras_amount) / 100) }"
      console.log extras

    # Upon submission of order item
    $("#food_menu_confirm").click ->

      # Store the cart in somewhere
      window.cart.push
        food_menu_id: chosen_menu.id
        quantity: 1
        extras: extras

      # Populate table

      # TODO: Close modal