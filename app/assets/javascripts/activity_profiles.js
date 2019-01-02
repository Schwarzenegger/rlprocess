var ActivityProfilesController = Paloma.controller('ActivityProfiles');

ActivityProfilesController.prototype.index = function() {
  General.enableFootable();
  General.enableCrudModal();
};
