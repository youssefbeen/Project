
$(document).on("turbolinks:load", function(){
    function obtenirParametre (sVar) {
  return unescape(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + escape(sVar).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
}

//alert(obtenirParametre("id"));
    $("select option").each(function(){
        if ($(this).val() == obtenirParametre("id")){
            $(this).attr("selected", "selected");
        }
    });
      $.validator.setDefaults({
        errorClass: 'help-block',
        highlight: function(element) {
          $(element)
            .closest('.form-group')
            .addClass('has-error');
        },
        unhighlight: function(element) {
          $(element)
            .closest('.form-group')
            .removeClass('has-error');
        },
        errorPlacement: function (error, element) {
          if (element.prop('type') === 'checkbox') {
            error.insertAfter(element.parent());
          } else {
            error.insertAfter(element);
          }
        }
      });
    $.validator.addMethod('strongPassword', function(value, element) {
    return this.optional(element)
      || value.length >= 6
      && /\d/.test(value)
      && /[a-z]/i.test(value);
  }, 'Your password must be at least 6 characters long and contain at least one number and one char\'.');

   $("#article-form").validate({
    rules: {
      "article[title]": {
        required: true,
        minlength: 3,
      },
      "article[description]": {
        required: true,
        minlength: 30,
      },
      "article[price]": {
        required: true,
        digits: true
      },
      "article[user_attributes][username]": {
        required: true,
        minlength: 3,
      },
      "article[user_attributes][email]": {
        required: true,
        email: true,
        remote: "/users/check_email"
      },
      "article[user_attributes][password]": {
        required: true,
        strongPassword: true
      },
      "article[user_attributes][password_confirmation]": {
        required: true,
        equalTo: '#password'
      },
      "article[user_attributes][tel]": {
        required: true,
        digits: true
      }},
    messages: {
      "article[user_attributes][email]": {
        required: 'Please enter an email address.',
        email: 'Please enter a <em>valid</em> email address.',
        remote: $.validator.format("{0} is already associated with an account.")
      }
    }
  });

});
