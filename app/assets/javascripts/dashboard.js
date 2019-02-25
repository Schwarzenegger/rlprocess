var DashboardController = Paloma.controller('Dashboard');

DashboardController.prototype.index = function() {
  showActivityInformation();
  handleSortableLists();
};

function showActivityInformation(){
  $('ul').on('click', 'li', function(event) {

      var activityId = $(this).attr("id").split('-')[1]

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
