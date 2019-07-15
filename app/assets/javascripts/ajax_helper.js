$(document).ready(function(){
  function message(msg, size ='small'){
    bootbox.alert({
      message: msg,
      size: size
    });
  }

  function finish_subject(subj_user_id, msg){
    message('You\'re finished this subject. <br />Congratulation !!!');
    setTimeout(() => {
      $('div.vcenter#'+subj_user_id).find('.progress-bar').removeClass('progress-bar-striped active').addClass('progress-bar-danger').css('width','100%');
      $('div.vcenter#'+subj_user_id).find('.label-primary').removeClass('label-primary').addClass('label-danger').html('Finish');
      $('div.vcenter#'+subj_user_id).find('#btn-finish'+subj_user_id).remove();
    }, 1000);
  }

  function waiting(){
    let html = '<div class="waiting"><span></span><span></span><span></span><span></span></div>';
    return html
  }

  $('.btn-load-modal').click(function(){
    let id = $(this).attr('data-id');
    $('#btn-delete').attr('data-id', id)

  });

  $('#btn-delete').click(function () {
    let id = $(this).attr('data-id');
    let url = $(this).context.baseURI + '/' + id;
    $.ajax({
      method: 'DELETE',
      dataType: 'json',
      url,
      success: function (data) {
        $('#data-row-id-' + id).remove();
        $('#myModal').modal('hide');
        $('#showmsg').append('<div class="alert alert-'+ data.cls + '">'
          +data.msg+'</div>');
      },
    });
  });


// view task by user


  $('.view-task').click(function(){
    const subj_user_id = $(this).attr('id');
    let subjet_id = $(this).attr('data-id');
    $.ajax({
      method : 'GET',
      dataType : 'JSON',
      data : {
        subj_user_id : subj_user_id,
        subjet_id : subjet_id
      },
      url : '/user/details_task',
      success: (result) => {
       if (result.length > 0) {
        let subject = result[0];
        let tasks = result[1];
        let html ='';
        $('.subj-name').attr('id',subject.id).html(subject.name);
        $('#subj-des').html(subject.description);
        $('#subj-img').attr('src', subject.picture.url);
          // console.log(tasks);
          tasks.forEach((task) => {
           html += '<span class="label label-primary">'+task.name+'</span>';
          if (task.status === 'studying') {
            html += '<span class="label label-danger finish-task" id="'+task.progress_user_id+'">Finish</span>';
          } else if(task.status === 'finish') {
            html += '<span class="label label-success">Finished</span>';
          }
            html += '<br />';
        });
          $('#subj-tasks').html(html);
          $('#task-modal').modal('show');
        }else{
          alert("Error");
        }
      }
    }).done(()=>{
      $('body').on('click','.finish-task',(e) => {
        const id_task = e.target.id;
        $.ajax({
          method : 'PATCH',
          dataType : 'JSON',
          data : {
            id_task : id_task,
            subject_user_id : subj_user_id,
          },
          url : '/user/finish_task',
          success: (result) => {
            $('span.finish-task#'+id_task).replaceWith('<span class="label label-success">Finished</span>');
          },
        }).done(() => {
          let count = $("span.finish-task:contains('Finish')").length;
          if (count === 0) {
            $('#task-modal').modal('hide');
            finish_subject(subj_user_id);
          }
        }).fail(()=> {
          message("Please try again later!");
        });
      });
    });
  });

  $('.finish_subject').click(function() {
    const subj_user_id = $(this).attr('id');
    $(this).remove();
    $('#btn-finish19').append(waiting());
    setTimeout(() => {
    $.ajax({
      method : 'PATCH',
      dataType : 'JSON',
      data : {
        subj_user_id : subj_user_id,
      },url : '/user/finish_subject',
      success: (result) => {
        finish_subject(subj_user_id);
      }
    }).fail(() => {
      message("Please try again later!");
    });
  }, 3000);
  });



  $(".view-subject-task").click(function(){
   $('.hover_bkgr_fricc').show();
  });
  $('.hover_bkgr_fricc').click(function(){
    $('.hover_bkgr_fricc').hide();
  });
  $('.popupCloseButton').click(function(){
    $('.hover_bkgr_fricc').hide();
  });

  $('.view-subject-task').click(function(){
    let subject_id = $(this).attr('id');
    let html = '';
    $.ajax({
      method : 'GET',
      dataType : 'JSON',
      data : {
        subject_id : subject_id,
      },url : '/detail_tasks',
      success: (data) => {
        data.forEach((task) => {
          html += '<span class="label label-warning">'+task.name+'</span><br />';
        });
        $('#list-task').html(html);
      }
    });
  });
});
