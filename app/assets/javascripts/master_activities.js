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

      $('#master_activity_deadline_date').val('');
      $('#master_activity_deadline_month').val('')
      $('#master_activity_deadline_month option:selected').removeAttr('selected');
      $('#master_activity_deadline_month').trigger('chosen:updated')
      $('#master_activity_deadline_day').val('');

      break;
    case 'montly':
      $('.deadline-date-col').hide();
      $('.deadline-month-col').hide();
      $('.deadline-day-col').show();

      $('#master_activity_deadline_date').val('');
      $('#master_activity_deadline_month').val('')
      $('#master_activity_deadline_month option:selected').removeAttr('selected');
      $('#master_activity_deadline_month').trigger('chosen:updated')

      break;
    case 'quarterly':
      $('.deadline-date-col').hide();
      $('.deadline-month-col').show();
      $('.deadline-day-col').show();

      $('#master_activity_deadline_date').val('');

      break;
    case 'anual':
      $('.deadline-date-col').hide();
      $('.deadline-month-col').show();
      $('.deadline-day-col').show();

      $('#master_activity_deadline_date').val('');

      break;
    case 'single_time':
      $('.deadline-date-col').show();
      $('.deadline-month-col').hide();
      $('.deadline-day-col').hide();

      $('#master_activity_deadline_month').val('')
      $('#master_activity_deadline_month option:selected').removeAttr('selected');
      $('#master_activity_deadline_month').trigger('chosen:updated')
      $('#master_activity_deadline_day').val('');

      break;
  }
}

function onFrequenceChange(){
  $('#master_activity_frequency').on('change', function() {
    setupFrequencyFields()
  });
}

function handleCheckBoxOptions(){
  $('.i-checks').on('ifChanged', function(event) {
    alert('checked = ' + event.target.checked);
    alert('value = ' + event.target.value);
  });

}

function setupMasterActivityForm(){
  setupComponents();
  setupFrequencyFields()
  onFrequenceChange();
  handleCheckBoxOptions();
}
