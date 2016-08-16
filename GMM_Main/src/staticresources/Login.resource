$(document).ready(function()
{

// Please read these set of code after you read next set. So that you can understand simply.
var username=$.cookie("username");   // Get username from cookie on form load.
if(username!=undefined)
{
     $('#loginsubmit').val(username);   // Display username on input box if avail on cookie.
      $('#c1').prop('checked', true);  // Check check box manually by us. So that duration for current email will reset.
}

// Read this set first.
$('#loginsubmit').click(function()
{
      if($('#c1').is(':checked')) // If user checked remember me check box
     {
                var email=$('#loginsubmit').val(); // Get entered username or email
                //  Set username on cookie when login form submit.
                $.cookie("username", email, { expires: 365 });  // Remember username for 1 year.
     }
      // Your other codes...
}

});