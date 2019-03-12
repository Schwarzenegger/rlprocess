var MasterActivitiesController = Paloma.controller('MasterActivities');

MasterActivitiesController.prototype.index = function() {
  General.enableFootable();
  General.enableCrudModal();
};

function setupFrequencyFields(){
  switch ($('#master_activity_frequency').val()) {
    case '':
      $('.deadline-date-col').hide();
      $('.deadline-month-col').hide();
      $('.deadline-day-col').hide();
      $('.competence-col').hide();

      $('#master_activity_deadline_date').val('');
      $('#master_activity_deadline_month').val('')
      $('#master_activity_deadline_month option:selected').removeAttr('selected');
      $('#master_activity_deadline_month').trigger('chosen:updated')
      $('#master_activity_deadline_day').val('');
      $('#master_activity_competence').val('');

      break;
    case 'montly':
      $('.deadline-date-col').hide();
      $('.deadline-month-col').hide();
      $('.deadline-day-col').show();
      $('.competence-col').show();

      break;
    case 'quarterly':
      $('.competence-col').hide();
      $('.deadline-date-col').hide();
      $('.deadline-month-col').show();
      $('.deadline-day-col').show();

      $("#master_activity_deadline_month").chosen("destroy")
      $("#master_activity_deadline_month").chosen({ max_selected_options: 4 })

      break;
    case 'annual':
      $('.competence-col').hide();
      $('.deadline-date-col').hide();
      $('.deadline-month-col').show();
      $('.deadline-day-col').show();

      $("#master_activity_deadline_month").chosen("destroy")
      $("#master_activity_deadline_month").chosen({ max_selected_options: 1 })
      $('#master_activity_deadline_month').trigger('chosen:updated')
      break;
    case 'single_time':
      $('.competence-col').hide();
      $('.deadline-date-col').show();
      $('.deadline-month-col').hide();
      $('.deadline-day-col').hide();

      break;
  }
}

function onFrequenceChange(){
  $('#master_activity_frequency').on('change', function() {
    $('#master_activity_competence').val('');
    $('#master_activity_deadline_day').val('');
    $('#master_activity_deadline_date').val('');
    $('#master_activity_deadline_month').val('')
    $("#master_activity_deadline_month").chosen("destroy")
    $("#master_activity_deadline_month").chosen({ max_selected_options: 3 })
    $('#master_activity_deadline_month option:selected').removeAttr('selected');
    $('#master_activity_deadline_month').trigger('chosen:updated')

    setupFrequencyFields()
  });
}


function setupMasterActivityForm(){
  setupComponents();
  setupFrequencyFields();
  onFrequenceChange();
}
