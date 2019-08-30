$(document).ready(function () {
  $('.modal-users').modal({
    backdrop: 'static',
    keyboard: true,
    show: false
  });

  $('table.users').DataTable({
    columnDefs: [
      {
        targets: 'no-sort',
        orderable: false
      }
    ],
    responsive: true,
    // sPaginationType: 'full_numbers',
    scrollY: "500px",
    scrollCollapse: true,
    // bJQueryUI: true,
    paging: false,
  });

  $('.btn-assign').click(function (event) {
    $('table.users input.chk-user:checkbox:checked')
      .each(function (index, data) {
        let avatar = data.dataset.avatar;
        let fullname = data.dataset.fullname;
        let email = data.dataset.email;
        let birthday = data.dataset.birthday;
        let gender = data.dataset.gender;
        let time = new Date().getTime();

        let option_user_id = `<input type="hidden" value="${data.value}"
          name="course[course_users_attributes][${time}][user_id]"
          id="course_course_users_attributes_${time}_user_id">`;
        let option_destroy = `<input type="hidden" value="false"
          name="course[course_users_attributes][${time}][_destroy]"
          id="course_course_users_attributes_${time}__destroy">`;
        let option_remove = `<a class="remove_record remove-position" href="#">
          <i class="fa fa-trash"></i></a>`;
        let str_row = `<tr data-id="${data.value}" style="display: table-row">
          <td>${option_user_id}<img class="img-circle avatar-size"
          src="${avatar}" alt="${fullname}"></td><td class="fullname-col">
          ${fullname}</td><td class="email-col">${email}</td>
          <td class="birthday-col">${birthday}</td>
          <td class="gender-col"><i class="fa fa-${gender}"></i></td>
          <td class="option">${option_destroy} ${option_remove}</td></tr>`;
        $('.trainees-data-tables').append(str_row);
      });
  });

  $('form').on('click', '.remove_record', function (event) {
    $(this).siblings('input[type=hidden]').val('1');
    $(this).closest('tr').remove();
    return event.preventDefault();
  });

  $(".dataTables_scrollHeadInner").css("width", "100%");
  $(".dataTables_scrollHeadInner table").css("width", "100%");

  $(window).on('shown.bs.modal', function () {
    if ($('table.users tbody tr').length > 0) {
      // hide rows assigned
      $('table.users tbody tr').css('display', 'table-row');

      $('.trainees-data-tables tr[style*="display: table-row"]')
        .each(function (index, data) {
          $('table.users tbody tr[data-id='
            + (data.attributes["data-id"].value) + ']').css('display', 'none');
        });

      // fix width headers
      let columns_count = $('.dataTables_scrollHead th').length;
      $('.dataTables_scrollHead th').css('padding', '10px 0px');
      $('table.users tbody tr[style="display: table-row"]:first td')
        .each(function (index, data) {
          if (index < columns_count - 1) {
            $('.dataTables_scrollHead th:nth-child('
              + (index + 1) + ')').css('width', data.clientWidth + 'px');
          }
        });

      // uncheck checkbox
      $('table.users td input[type="checkbox"]').attr('checked', false);
    }
  });

  $('.chk-all').change(function (event) {
    if(this.checked){
    //  display: table-row
      $('.users tr[style="display: table-row"] .chk-user')
        .each(function (index, data) {
        this.checked = true;
      });
    }
    else{
      $('.users tr .chk-user').each(function (index, data) {
        this.checked = false;
      });
    }
  });

});
