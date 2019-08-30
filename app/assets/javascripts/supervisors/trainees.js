$(document).ready(function () {
  $('.chk-all').change(function (event) {
    if(this.checked){
    //  display: table-row
    $('.table tr .checkbox').each(function (index, data) {
      this.checked = true;
      });
    }
    else{
      $('.table tr .checkbox').each(function (index, data) {
        this.checked = false;
      });
    }
  });

  $('.destroy').click(function () {
    const obj = $(this);
    var user_id = obj.attr('id');
    var course_id = window.location.pathname.slice(17);
    var url = window.location.origin + '/supervisors/trainees/' + user_id;
    let html = '<input value="'+course_id+'" type="hidden" name="course_user[course_id]" id="course_user_course_id">';
    html += '<input type="checkbox" name="course_user[user_ids][]" id="course_user_user_ids_" value="'+user_id+'" class="checkbox">';
    $.ajax({
      method: 'DELETE',
      data: {
        authenticity_token: $('[name="csrf-token"]')[0].content,
        course_id: course_id
      },
      dataType: 'json',
      url,
      success: function(result){
        if (result.status == "success") {
          obj.replaceWith(html);
        }else{
          alert(result.message);
        }
      }
    })
  });
});
