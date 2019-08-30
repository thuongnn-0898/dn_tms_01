$(document).ready(function(){

  setTimeout(function(){
    $('#flash_messages').slideUp();
  },3000);

  $('#more_task').click(function(){
    var input = $('.task_more:last').clone();
    if(input.length == 0){
      let html ='<br/><span class="fa fa-cut remove_task"></span><input type="text" name="subject[tasks_attributes][0][name]" id="subject_tasks_attributes_0_name" class="task_more">';
      $('#tasks').append(html);
    }else{
      var Id = input.attr('id').replace(/subject_tasks_attributes_(\d+)_name/, "$1");
      newId = parseInt(Id)+1;
      let html ='<br/><span class="fa fa-cut remove_task"></span><input type="text" name="subject[tasks_attributes]['+newId+'][name]" id="subject_tasks_attributes_'+newId+'_name" class="task_more">';
      $('#tasks').append(html);
    }
  });

  $('#tasks').on('click', '.remove_task', function() {
    $(this).prev().remove();
    $(this).next().remove();
    $(this).remove()
  });


// delete task
  $('.task').dblclick(function(){
    var totalTask = $('.task').length;
    if (confirm("Delete this task?")) {
      if(totalTask == 1){
        $('h3').append('<span class="badge badge-danger">At least 1 task </span');
      }else{
        var item = $(this);
        let id = item.attr('id');
        let url = window.location.origin + '/supervisors/tasks/' + id;
        $.ajax({
          method: 'DELETE',
          data: { authenticity_token: $('[name="csrf-token"]')[0].content},
          dataType: 'json',
          url,
          success: function(result){
            item.remove();
          }
        })
      }
    }
  });


// count total select box
  $('input[type="checkbox"]').click(function(){
    $('#count').html($('.checkbox:checked').length);
  });
  $('#count').html($('.checkbox:checkbox:checked').length);

      var readURL = function(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('.picture').attr('src', e.target.result);
            }

            reader.readAsDataURL(input.files[0]);
        }
    }
    $(".file-upload").on('change', function(){
        readURL(this);
    });
})
