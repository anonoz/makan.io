$ ->
  food_option_field_name_prefix = "order_item[extras_attributes][]"
  choice_id_field_name = food_option_field_name_prefix + "[food_option_choice_id]"
  quantity_field_name = food_option_field_name_prefix + "[quantity]"

  # Bind choose_multiple checkboxes
  #
  # - TODO: Impose minimum and maximum selection limit
  $("#visible-food-option-form input:checkbox").change (e)->
    form_field = $("#hidden_form_field_#{ $(this).data("food-option-id") }")

    if $(this).prop("checked")
      # Add selected choice to invisible form
      form_field.append $("<input></input>").attr
        name: choice_id_field_name
        value: $(this).data("food-option-choice-id")
        "data-choice-id": $(this).data("food-option-choice-id")
    else
      # Remove from the invisible form
      form_field.find("input[data-choice-id=#{ $(this).data("food-option-choice-id") }]").remove()

  # Bind choose_one radio button
  $("#visible-food-option-form input:radio").change (e)->
    $("#hidden_form_field_#{ $(this).data("food-option-id") }").empty().append $("<input></input>").attr
      name: choice_id_field_name
      value: $(this).data("food-option-choice-id")
      "data-choice-id": $(this).data("food-option-choice-id")

  # Add default chosen radio to form field
  $("#visible-food-option-form input:radio").change()

  # Bind quantities numerical input
  $("#visible-food-option-form input[type=number]").change (e)->
    form_field = $("#hidden_form_field_#{ $(this).data("food-option-id") }")
    relevant_fields = form_field.find("input[data-choice-id=#{ $(this).data("food-option-choice-id") }]")
    
    if $(this).val() > 0
      # Find existing relevant fields (choice_id and quantity) in form field, else...
      

      # Create the form fields if it wasnt exist
      if (!relevant_fields.length)
        choice_id_field = $("<input></input>").attr
          name: choice_id_field_name
          value: $(this).data("food-option-choice-id")
          "data-choice-id": $(this).data("food-option-choice-id")

        quantity_field = $("<input></input>").attr
          name: quantity_field_name
          value: $(this).val()
          "data-choice-id": $(this).data("food-option-choice-id")

        form_field.append(choice_id_field).append(quantity_field)

      # Update the quantity, which should always be at second position.
      else
        $(relevant_fields[1]).val $(this).val()

    else
      relevant_fields.remove()

