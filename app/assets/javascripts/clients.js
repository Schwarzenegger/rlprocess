var ClientsController = Paloma.controller('Clients');

ClientsController.prototype.index = function() {
  General.enableFootable();
  General.enableCrudModal();
};

ClientsController.prototype.new = function() {
  setupClientForm();
};

ClientsController.prototype.edit = function() {
  setupClientForm();
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

function addActivitiesOnProfileChange(){
  $('#client_activity_profile_ids').on('change', function(event, params)  {
    if(params.deselected != undefined){
      $.ajax({
        type: "GET",
        url: '/clients/handle_profile_change',
        dataType: 'script',
        data: { deselected_id: params.deselected }
      });
    }else if (params.selected != undefined) {
      $.ajax({
        type: "GET",
        url: '/clients/handle_profile_change',
        dataType: 'script',
        data: { selected_id: params.selected }
      });

    }
  });
}
