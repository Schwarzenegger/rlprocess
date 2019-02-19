var DashboardController = Paloma.controller('Dashboard');

DashboardController.prototype.index = function() {
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


};
