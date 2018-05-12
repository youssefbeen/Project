
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
        
   $("#register-form").validate({
    rules: {
      email: {
        required: true,
        email: true,
        remote: "/users/check_email"
      },
      username: "required",
      password: {
        required: true,
        strongPassword: true
      },
      password2: {
        required: true,
        equalTo: '#password'
      },
      phone: {
        required: true,
        digits: true
      }},
    messages: {
      email: {
        required: 'Please enter an email address.',
        email: 'Please enter a <em>valid</em> email address.',
        remote: $.validator.format("{0} is already associated with an account.")
      }
    }
  });

});