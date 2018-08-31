function openModal(mainEvent) {
  var target = $(mainEvent.target);
  $(target).attr("disabled", "disabled");
  var target_url = $(target).data("url");
  $.ajax({
    type: "GET",
    url: target_url,
    dataType: 'script',
    success: function() {
      $(target).removeAttr('disabled');
    }
  });
  mainEvent.preventDefault();
}

function editModal(mainEvent) {
  var target = $(mainEvent.target).closest("a");
  $(target).attr("disabled", "disabled");
  var target_url = $(target).data("url");
  $.ajax({
    type: "GET",
    url: target_url,
    dataType: 'script',
    success: function() {
      $(target).removeAttr('disabled');
    }
  });
  mainEvent.preventDefault();
}

function deleteModalObject(event, confirm_message) {
  if (confirm(confirm_message)) {
    var target_url = $(event.target).closest("a").data("url");
    $.ajax({
      type: "DELETE",
      url: target_url,
      dataType: 'script'
    });
  }
  event.preventDefault();
}

function remoteModalSubmit(form_id, event) {
  var form = $(form_id).find('form')[0];
  var target = $(event.target);
  $(target).prop("disabled", true);
  $.ajax({
    type: $(form).attr('method'),
    url: $(form).attr('action'),
    data: $(form).serialize(),
    dataType: 'script',
    success: function(event) {
      $(target).prop("disabled", false);
    },
    error:  function(event) {
      $(target).prop("disabled", false);
    }
  });
  event.preventDefault();
}

function showModalWindow(modal_id) {
  $("#" + modal_id).modal("show");
}

function hideModalWindow(modal_id) {
  $("#"+modal_id).modal('hide');
}
