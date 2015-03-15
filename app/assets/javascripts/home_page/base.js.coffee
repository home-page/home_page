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
      
  $(document.body).on 'click', '.remote_modal_link', (event) ->
    $this = $(this)
    
    url = if $this.data('url') then $this.data('url') else $this.attr('href')
    
    $.ajax(url: url, type: 'GET', dataType: 'html').success (data) ->
      $('#bootstrap_modal').html(data)
      $('#bootstrap_modal').modal(show: true, keyboard: false)
      
    event.preventDefault()
    
  $(document.body).on 'click', '#close_bootstrap_modal_button', (event) ->
    $('#bootstrap_modal').modal('hide')
    event.preventDefault()