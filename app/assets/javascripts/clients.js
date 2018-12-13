var ClientsController = Paloma.controller('Clients');

ClientsController.prototype.index = function() {
  General.enableFootable();
  General.enableCrudModal();
};
