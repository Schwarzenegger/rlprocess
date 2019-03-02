var DashboardController = Paloma.controller('Dashboard');

DashboardController.prototype.index = function() {
  showActivityInformation();
  handleSortableLists();
  startActivity();
  restartActivity();
  finishActivity();
  goBackAMonth();
  fowardAMonth();
};

function goBackAMonth(){
  $('.back-month').on('click', function(event) {
    var target = $(event.target);
    $(target).attr("disabled", "disabled");

    monthValue = parseInt($('#dashboard_month').val()) - 1
    if(monthValue == 0){
      monthValue = 12
      yearValue = parseInt($('#dashboard_year').val()) - 1
    }else{
      yearValue = parseInt($('#dashboard_year').val())
    }

    window.location = '/dashboard?month=' + monthValue + "&year=" + yearValue
  });
}

function fowardAMonth(){
  $('.foward-month').on('click', function(event) {
    var target = $(event.target);
    $(target).attr("disabled", "disabled");

    monthValue = parseInt($('#dashboard_month').val()) + 1
    if(monthValue == 13){
      monthValue = 1
      yearValue = parseInt($('#dashboard_year').val()) + 1
    }else{
      yearValue = parseInt($('#dashboard_year').val())
    }

    window.location = '/dashboard?month=' + monthValue + "&year=" + yearValue
  });
}

function startActivity(){
  $('.start-activity').off('click')
  $('.start-activity').on('click', function(event) {
    var target = $(event.target);
    $(target).attr("disabled", "disabled");

    var activityId = $(this).attr("id").split('-')[2]
    $.ajax({
      type: "PUT",
      url: "/activities/" + activityId + "/start",
      dataType: 'script',
      success: function() {
        $(target).removeAttr('disabled');
      }
    });
  });
}

function restartActivity(){
  $('.restart-activity').off('click')
  $('.restart-activity').on('click', function(event) {
    var target = $(event.target);
    $(target).attr("disabled", "disabled");

    var activityId = $(this).attr("id").split('-')[2]
    $.ajax({
      type: "PUT",
      url: "/activities/" + activityId + "/restart",
      dataType: 'script',
      success: function() {
        $(target).removeAttr('disabled');
      }
    });
  });
}

function finishActivity(){
  $('.finish-activity').off('click')
  $('.finish-activity').on('click', function(event) {
    var target = $(event.target);
    $(target).attr("disabled", "disabled");

    var activityId = $(this).attr("id").split('-')[2]
    $.ajax({
      type: "PUT",
      url: "/activities/" + activityId + "/finish",
      dataType: 'script',
      success: function() {
        $(target).removeAttr('disabled');
      }
    });
  });
}

function showActivityInformation(){
  $('.activity-details').on('click', function(event) {

      var activityId = $(this).attr("id").split('-')[2]

      $.ajax({
        type: "GET",
        url: "/activities/" + activityId,
        dataType: 'script',
        success: function() {
        }
      });
  });
}

function handleSortableLists(){
  $("#todo, #inprogress, #completed").sortable({
      connectWith: ".connectList",
      update: function( event, ui ) {
        if (this === ui.item.parent()[0]) {

          var activityId = ui.item.attr("id").split('-')[1]
          var destination = ui.item.closest('ul').attr('id')

          $.ajax({
            type: "PUT",
            url: '/activities/' + activityId,
            dataType: 'script',
            data: { destination: destination }
          });
        }
      }
  }).disableSelection();
}

function whenOptionIsChecked(){
  $('.i-checks').on('ifChanged', function(event) {
    var optionId = event.target.id.split('-')[1]

    $.ajax({
      type: "PUT",
      url: '/activities/mark_option',
      dataType: 'script',
      data: { checked: event.target.checked, optionId: optionId }
    });

  });
}
