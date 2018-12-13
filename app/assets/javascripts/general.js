String.prototype.interpolate = function (o) {
  return this.replace(/{([^{}]*)}/g,
    function (a, b) {
      var r = o[b];
      return typeof r === 'string' || typeof r === 'number' ? r : a;
    }
  );
};

var General = {
  enableCrudModal: function(){
    $('.open-crud-modal').on('click', function(event){
      event.preventDefault();
      openModal(event);
    });
  },

  enableICheck: function(){
    $('.i-checks').iCheck({
      checkboxClass: 'icheckbox_square-aero',
      radioClass: 'iradio_square-aero',
    });
  },

  enablePopovers: function(){
    $('[data-toggle="popover"]').popover({ html: true, container: 'body' });
  },

  enableFootable: function(){
    $('.footable').footable({
      paginate: false
    });
  },

  enableFootableWithPagination: function(){
    $('.footable').footable({
      paginate: true
    });
  },

  enableTooltips: function(){
    $('[data-toggle="tooltip"]').tooltip({
      html: true,
      container : 'body',
      trigger : 'hover'
    });
  },

  submit: function() {
    $('.btn-submit').click(function(e) {
      e.preventDefault();
      $(this).closest('form').submit()
    });
  }
}

var Mask = {
  timePicker: function() {
    $(".time-picker").each(function() {
      $(this).mask("99:99");
      $(this).datetimepicker({
        dateFormat: '',
        timeFormat: 'HH:mm',
        use24hours: true,
        locale: moment.locale('pt-br'),
        icons: {
          next: "fa fa-chevron-right",
          previous: "fa fa-chevron-left"
        }
      })
    })
  },

  datePicker: function() {
    $(".date-time-picker").each(function() {
      $(this).mask("99/99/9999");
      $(this).datetimepicker({
        format: 'DD/MM/YYYY',
        locale: moment.locale('pt-br'),
        icons: {
          next: "fa fa-chevron-right",
          previous: "fa fa-chevron-left"
        }
      })
    })
  },

  cellphone: function() {
    $(".phone").mask("(99)99999-9999");
  },

  cpf: function() {
    $(".cpf").mask("999.999.999-99");
  },

  cnpj: function() {
    $(".cnpj").mask("99.999.999/9999-99");
  },

  money: function() {
    $(".currency").attr("data-prefix", "R$ ").attr("data-thousands", ".").attr("data-decimal", ",").maskMoney();
    $('.currency').each(function() {
      var value = $(this).attr('value');
      value = parseFloat(value).toFixed(2);
      $(this).attr('value', value);
      $(this).maskMoney('mask', $(this).attr('value'));
    })
  },

  justNumbers: function() {
    $('.numbers-only').keyup(function () {
      this.value = this.value.replace(/[^0-9\,]/g,'');
    });
  }
}

function bootApp(){
  Paloma.start();
  setupComponents();
}

function setupComponents(){
  General.enableICheck();
  General.enableTooltips();
  General.enablePopovers();
  Mask.datePicker();
  Mask.cpf();
  Mask.cnpj();
}

$(document).ready(function(){
   bootApp();
});
