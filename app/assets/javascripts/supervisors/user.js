$('.modal-footer #btn-delete').click(function () {
  let id = $(this).attr('data-id');
  $.ajax({
    method: 'DELETE',
    dataType: 'json',
    url: '/supervisor/users/' + id,
    data: {
      id: id,
    }, success: function (data) {
      $('.table #user_id' + id).remove();
      $('#myModal').modal('hide');
      $('#showmsg').append('<div class="alert alert-'
        + data.cls + '">'+data.msg+'</div>');
    }
  });
});

$('.action .btn-remove').click(function () {
  let id = $(this).attr('data-id');
  $('.modal-footer #btn-delete').attr('data-id', id)
});
