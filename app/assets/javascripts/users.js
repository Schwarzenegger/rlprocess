var UsersController = Paloma.controller('Users');

UsersController.prototype.index = function() {
  General.enableFootable();
  General.enableCrudModal();
};
