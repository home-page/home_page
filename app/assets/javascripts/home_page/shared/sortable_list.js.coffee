window.HomePage or= {}; window.HomePage.Shared or= {}

window.HomePage.Shared.SortableList = class SortableList
  constructor: (selector) ->
    $(selector).multisortable
      start: (event, ui) =>
        window.HomePage.Shared.SortableList.showSpinnerForSelectedItems(ui.item.data('sortable_selector'))
        
      update: (event, ui) =>
        $(ui.item.data('sortable_selector')).sortable('disable')
        url = $(ui.item.data('sortable_selector')).data('url')
        setTimeout (->
          window.HomePage.Shared.SortableList.putPositions ui.item.data('sortable_selector'), ui.item.data('id'), url
          return
        ), 1000
        
  @showSpinnerForSelectedItems: (selector) ->
    $.each $("#{selector} li.selected"), (index, element) ->
      $(element).find('.sorting_spinner').show()

  @hideSpinnerForSelectedItems: (selector) ->
    $.each $("#{selector} li.selected"), (index, element) ->
      $(element).find('.sorting_spinner').hide()
      
  @putPositions: (selector, id, url) ->
    window.HomePage.Shared.SortableList.resetPositions(selector)
    
    positions = {}
        
    $.each $("#{selector} li.selected"), (index, element) ->
      positions[$(element).data('position')] = $(element).data('id')
    
    $.post(url, { _method: 'put', positions: positions }).always(=>
      $(selector).sortable('enable')
      window.HomePage.Shared.SortableList.hideSpinnerForSelectedItems()
    )
   
  @resetPositions: (selector) ->
    current_position = 1
    
    $.each $("#{selector} li"), (index, element) ->
      $(element).data('position', current_position)  
      $(element).find('.item_position').html(current_position)
      current_position += 1