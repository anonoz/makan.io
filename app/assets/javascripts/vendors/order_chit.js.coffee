#= require underscore-min
#= require handlebars-v3.0.1
#= require typeahead.bundle

Handlebars.registerHelper 'ringgit', (amount, options)-> currencify amount

$(document).ready ->

  window.cart = []
  window.temp_id = 0
  
  # Unpack the data
  food_menus = JSON.parse $('#food_menus_data').text()
  food_options = JSON.parse $('#food_options_data').text()
  all_food_option_choices = _.flatten _.pluck food_options, "choices"

  customizer = $('#food_customizer')
  items_list = $('#items_list')

  $("a[data-reveal-id=add_item_modal]").click ->
    # Reset
    $("#food_menu_typeahead").typeahead "val", null
    onFoodMenuChange null

  # Typeahead for food menu
  food_menu_typeahead_engine = new Bloodhound
    local: food_menus
    identify: (menu)-> menu.id
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace("title")
    queryTokenizer: Bloodhound.tokenizers.whitespace

  console.log food_menu_typeahead_engine

  $("#food_menu_typeahead").typeahead {
    hint: true
  }, {
    name: "food_menus"
    display: "title"
    source: food_menu_typeahead_engine
    templates:
      empty: "<h4> Food not found </h4>"
      suggestion: Handlebars.compile [
          "{{#if available}}",
            "<div>{{ title }}</div>",
          "{{else}}",
            "<div class='food_unavailable'>{{ title }} ({{ unavailability_reason }})</div>",
          "{{/if}}"
        ].join "\n"
  }

  $("#food_menu_typeahead").bind "typeahead:select", (e, suggestion)->
    onFoodMenuChange suggestion

  # In modal
  onFoodMenuChange = (food_menu = null)->
    window.chosen_menu = food_menu

    # RESET
    extras = []
    base_amount = chosen_menu && chosen_menu.base_price_cents || 0
    count_item_amount chosen_menu, extras

    # Display the form in step 2
    customizer.html("")
    $("#food_menu_confirm").off "click"
    $("#kena_gst, #kena_delivery_fee").addClass "hide"

    if chosen_menu
      if chosen_menu.available 
        $("#food_menu_confirm").show()
      else
        $("#food_menu_confirm").hide()

      if chosen_menu.kena_gst
        $("#kena_gst").removeClass("hide")

      if chosen_menu.kena_delivery_fee
        $("#kena_delivery_fee").removeClass "hide"
    else
      customizer.html("<p>Choose some food first.</p>")
      $("#food_menu_confirm").hide()

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
        choice = _.findWhere(food_option.choices, {id: Number this.value})
        extras.push
          food_option_choice_id: Number this.value
          quantity: 1
          amount_cents: choice.unit_amount_cents
          title: "#{ choice.title } - #{ currencify choice.unit_amount_cents }"
      else
        extras = _.reject extras, (choice)->
          console.log choice
          choice.food_option_choice_id == Number element.value

      extras_amount = _.reduce extras, (memo, nu)->
        memo + nu.unit_amount_cents
      , 0

      count_item_amount chosen_menu, extras

    # Bind choose one
    $(".choose_one_input").change ->
      other_choices = _.findWhere(food_options, {id: Number $(this).data("food-option-id")}).choices
      other_choices_ids = _.pluck other_choices, "id"
      console.log other_choices_ids

      # Delete all other choices in the same namespace
      extras = _.reject extras, (choice)->
        console.log choice.food_option_choice_id
        other_choices_ids.indexOf(choice.food_option_choice_id) > -1

      choice = _.findWhere(all_food_option_choices, {id: Number this.value})
      extras.push
        food_option_choice_id: Number this.value
        quantity: 1
        amount_cents: choice.unit_amount_cents
        title: "#{choice.title} - #{ currencify choice.unit_amount_cents }"

      extras_amount = _.reduce extras, (memo, nu)->
        memo + nu.unit_amount_cents
      , 0

      count_item_amount chosen_menu, extras

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
        amount_cents = _.findWhere(choices, {id: choice_id}).unit_amount_cents * quantity
        extras.push
          food_option_choice_id: choice_id
          quantity: quantity
          amount_cents: amount_cents
          title: "#{chosen_menu.title } x#{ quantity } - #{ currencify amount_cents }"
      
      extras_amount = _.reduce extras, (memo, nu)->
        memo + nu.unit_amount_cents
      , 0

      count_item_amount chosen_menu, extras

    # Upon submission of order item
    $("#food_menu_confirm").click ->
      # Item as hash
      console.log item =
        temp_id: ++temp_id
        food_menu_id: chosen_menu.id
        quantity: 1
        extras: extras
        title: chosen_menu.title
        kena_gst: chosen_menu.kena_gst
        kena_delivery_fee: chosen_menu.kena_delivery_fee
        amount_cents: count_item_amount chosen_menu, extras, false

      # Store the cart in somewhere
      window.cart.push item

      # Populate table
      items_list.append Handlebars.compile($('#chow_item_row').html()) item
      $("#total_amount").change()

      # Handle input change
      item_fieldset = $("fieldset[data-order-item-temp-id=#{ item.temp_id }]")
      item_fieldset.find("input.chit_row_qty_input").change ->
        item.quantity = Number this.value
        $("#total_amount").change()

      # Bind remove
      item_fieldset.find(".item_remove_button").click ->
        window.cart = _.reject window.cart, (cart_item)->
          cart_item.temp_id == item.temp_id
        $("#total_amount").change()
        item_fieldset.remove()

      # TODO: Close modal
      customizer.html ""
      $("#add_item_modal").foundation "reveal", "close"

  # The element itself doesn't actuallt change, but it's the 
  # total amount in model changing, liddis code more DRY,
  # albeit inappropriate lah.
  $("#total_amount").change ->
    # Calculate food
    total_amount_cents = _.reduce cart, (memo, nu)->
      memo + (nu.quantity * nu.amount_cents)
    , 0

    # Update the counter
    $("#total_amount").text currencify total_amount_cents

  # For edit page, we prepolate the form and cart
  if $("#items_data").length > 0
    items = JSON.parse $("#items_data").html()

    # First we fill up cart[]
    for item in items
      
      # Dirty hack for extras
      for extra in item.extras
        choice = extra.food_option_choice
        extra.title = "#{ choice.title } - #{currencify choice.unit_amount_cents}"
        extra.amount_cents = extra.quantity * choice.unit_amount_cents

      cart.push
        temp_id: ++temp_id
        item_id: item.id
        edit_mode: true
        food_menu_id: item.food_menu.id
        quantity: item.quantity
        extras: item.extras
        title: item.food_menu.title
        kena_gst: item.food_menu.kena_gst
        kena_delivery_fee: item.food_menu.kena_delivery_fee
        amount_cents: count_item_amount item.food_menu, item.extras, false

    # Inflate DOM for each items & Bind quantity + remove
    for item in window.cart
      items_list.append Handlebars.compile($('#chow_item_row').html()) item

      # Update quantity
      item_fieldset = $("fieldset[data-order-item-temp-id=#{ item.temp_id }]")
      item_fieldset.find("input.chit_row_qty_input").change ->
        item.quantity = Number this.value
        $("#total_amount").change()

      # Remove item in cart
      item_fieldset.find(".item_remove_button").click ->
        window.cart = _.reject window.cart, (cart_item)->
          cart_item.temp_id == item.temp_id
        $("#total_amount").change()

        # In this case, we keep the form, but we check _destroy
        item_fieldset.addClass("hide")
        item_fieldset.find(".destroy_checkbox").prop("checked", true)

    # Update subtotal
    $("#total_amount").change()

# Method to calculate charge for a single item
count_item_amount = (food_menu = {base_price_cents: 0}, extras = [], element = $("#amount_sum"))->
  # Base price
  original_price = food_menu.base_price_cents

  # Extras
  original_price += _.reduce extras, (memo, nu)->
    console.log [memo, nu]
    memo + nu.amount_cents
  , 0

  # GST and delivery fee
  final_price = original_price
  final_price += original_price * 0.06 if food_menu.kena_gst
  final_price += original_price * 0.10 if food_menu.kena_delivery_fee

  # Update element
  element && element.text currencify final_price

  return final_price

currencify = (cents = 0)-> "RM #{ (cents/100).toFixed 2 }"