$(document).ready ->
  $('[data-toggle="tabajax"]').click (e) ->
    $this = $(this)
    url = $this.attr('href')
    target = $this.attr('data-target')
    
    $.get url, (data) ->
      $(target).html data
      
    $this.tab 'show'
    
    false
    
  $(document.body).on 'show.bs.modal', '#modal', (event) ->
    button = $(event.relatedTarget)
    url = button.data('url')
    modal = $(this)
    
    if button.data('only-update-body') == true
      modal.find('.modal-title').text button.data('title')
      modal.find('.modal-body').load url
    else
      $('.modal-content').load url