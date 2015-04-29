var sparta = sparta || {};
sparta.rackMethodOverrides = {}

sparta.rackMethodOverrides.init = function(){
  sparta.rackMethodOverrides.links();
  sparta.rackMethodOverrides.forms();  
}

sparta.rackMethodOverrides.links = function(){
  $("a[data-method='put'], a[data-method='delete']").click(function(event){
    var method = $(this).attr("data-method"),
        action = $(this).attr("href"),
        confirmation = $(this).attr("data-confirm"),
        allowedMethods = ["put", "delete"],
        formMarkup = "<form method='post' action='/' id='rack_method_overrides'>"+
                     "<input type='hidden' name='_method' value='put|delete'/></form>";

    if (allowedMethods.indexOf(method) != -1) {
      event.preventDefault();
      event.stopPropagation();

      $("body").append(formMarkup);
      $form = $("#rack_method_overrides");
      
      $form.attr("action", action);
      $form.find("input").attr("value", method);

      if (confirmation != undefined) confirm(confirmation);

      $form.submit();
    }
  });
}

sparta.rackMethodOverrides.forms = function(){
  var $forms = $("form[method='put'], form[method='delete']");

  $forms.each(function(){
    method = $(this).attr("method");
    methodInput = "<input type='hidden' name='_method' value='"+method+"'/>";

    $(this).prepend(methodInput);
    $(this).attr("method", "post");
  });
}
