var MasterActivitiesController = Paloma.controller('MasterActivities');

MasterActivitiesController.prototype.index = function() {
  General.enableFootable();
  General.enableCrudModal();
};
