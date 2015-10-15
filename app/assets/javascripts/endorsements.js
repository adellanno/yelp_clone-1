$(document).ready(function() { //  a jQuery method that makes sure the page is fully loaded before the JS fires.

  $('.endorsements-link').on('click', function(event){ // when the user clicks on an HTML element with the class 'endorsements-link'...
    event.preventDefault();

    var endorsementCount = $(this).siblings('.endorsements_count'); // make a new variable called endorsementCount & – and tell that to refer to the HTML element with
    // class 'endorsements_count' that's next to the current element (we need to do this weirdness because we're getting a span element that's next to the link being clicked)...

    $.post(this.href, function(response){ // and then make a post request to the very same URL specified by the link that just got clicked...
      endorsementCount.text(response.new_endorsement_count); // and grab the response of that request and overwrite the endorsementCount element we defined before with that response (which will be the number of endorsements).
    })
  })
})
