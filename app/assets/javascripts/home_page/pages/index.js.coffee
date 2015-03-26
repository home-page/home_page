$(document).ready ->
  $(document.body).on 'click', '.page_module_collection_show_link', (event) ->
    $this = $(this)
    $this.find('.ajax_spinner').show()
    
    $.ajax(url: $this.attr('href'), type: 'GET', dataType: 'html').done((data) =>
      $this.find('.ajax_spinner').hide()
      $($this.data('replace')).html(data)
      new window.HomePage.Shared.SortableList('#page_module_collection_modules')
    ).fail((data) =>
      $this.find('.ajax_spinner').hide()
      alert 'Failed to load page!'
    )
    event.preventDefault()  
