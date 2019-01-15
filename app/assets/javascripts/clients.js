var ClientsController = Paloma.controller('Clients');

ClientsController.prototype.index = function() {
  General.enableFootable();
  General.enableCrudModal();
};

function hideSimplesPassword(){
  if($('#client_taxation').val() === 'simples'){
    $('.client_simples_password').show();
  }else{
    $('.client_simples_password').hide();
    $('#client_simples_password').val('');
  }
}

function setupTaxationSelect(){
  hideSimplesPassword()

  $('#client_taxation').on('change', function() {
    hideSimplesPassword()
  });
}

function setupClientForm(){
  setupComponents();
  setupTaxationSelect();
}
