# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
@add_new_photos = () ->
  $('a.service_exps').bind "click", () ->
    href = $(this).attr('href')
    id= $(this).attr('data-id')
    $("#modal").load href, (data) ->
#      $(this).modal "show"
#      $("#new_service_exp").enableClientSideValidations()
#      $("#edit_service_exp_"+ id).enableClientSideValidations()
    return false

