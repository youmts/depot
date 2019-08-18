// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require_tree .

(function() {
  // カード支払いページ用
  $(document).on('turbolinks:load', function() {
    console.log("load");
    const form = $("#charge-form")
    if (!form.length) {
      return;
    }

    console.log(form);

    const submit = form.find('input[name="commit"]');
    submit.on("click", e => {
      console.log("click");
      e.preventDefault();

      const number = form.find('input[name="number"]'),
        cvc = form.find('input[name="cvc"]'),
        exp_month = form.find('input[name="exp_month"]'),
        exp_year = form.find('input[name="exp_year"]');

      console.log(number);

      const card = {
        number: number.val(),
        cvc: cvc.val(),
        exp_month: exp_month.val(),
        exp_year: exp_year.val()
      };
      console.log(card);

      Payjp.createToken(card, function(s, response) {
        if (response.error) {
          form.find('.charge-errors').text(response.error.message);
          console.log('error');
          $.rails.enableFormElement(submit);
        }
        else {
          number.val('');
          cvc.val('');
          exp_month.val('');
          exp_year.val('');

          const token = response.id;
          console.log(token);

          form.append($('<input type="hidden" name="payjp_token" />').val(token));
          form.submit();
        }
      });
    });
  });
})();
