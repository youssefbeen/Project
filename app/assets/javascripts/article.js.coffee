# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on("turbolinks:load", ()->
    
    
  onAddFile = (event) ->
    
    file = event.target.files[0]
    url = URL.createObjectURL(file)
    thumbContainer = $(this).parents('div').siblings('div.thumb')
    if $(this).parent().hasClass("btn")
        $(this).parent().hide()
    if thumbContainer.find('img').length == 0
      thumbContainer.append('<img src="' + url + '" width = "80px" height= "60px" />')
    else
      thumbContainer.find('img').attr('src', url)
      
    
  charge = (event) -> 
    x = $(this).parents('div').siblings('div.thumb')
    if x.find('img').length != 0
        $(this).parent().hide()
            
    
        ####
  check_to_hide_or_show_add_link = ->
    if $('.body .nested-fields:visible').length == 4
      $('.user-photo-form div.links a').hide()
    else
      $('.user-photo-form div.links a').show()
    return
#    
  check_to_hide_or_show_remove_link = ->
    if $('.body .nested-fields:visible').length == 1
      $('.body .nested-fields div a').hide()
    else
      $('.body .nested-fields div a').show()
    return
  check_to_hide_or_show_remove_link()
 
  $('.body').on 'cocoon:after-remove', ->
    check_to_hide_or_show_add_link()
    check_to_hide_or_show_remove_link()
    return

    
  
        
  # for redisplayed file inputs and file inputs in edit page
  $('input[type=file]').each(()->
    x = $('input[type=file]').parents('div').siblings('div.thumb')
    if x.find('img').length != 0
      $('input[type=file]').parent().hide()
    $(this).change(onAddFile) 
  )

  # register event handler when new cocoon partial is inserted from link_to_add_association link
  $('.body').on('cocoon:after-insert', (e, addedPartial) ->
    $('input[type=file]', addedPartial).change(onAddFile)
    check_to_hide_or_show_add_link()
    check_to_hide_or_show_remove_link()
  )

  # tell cocoon where to insert partial
  $('a.add_fields').data('association-insertion-method', 'append')
  $('a.add_fields').data("association-insertion-node", 'div.user-photo-form .body')
)