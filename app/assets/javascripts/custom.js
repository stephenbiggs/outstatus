// for the notifications
$(function() {
  $('.callout').delay(500).fadeIn('normal', function() {
     $(this).delay(5000).fadeOut();
  });
});


// for the modal
$('.modal-link').on('click', function() {

  var modal = $(this).attr('data-open')

  console.log(modal)

  $('.modal[data-reveal=' + modal + ']').fadeIn(300)

  return false
})


$('.modal-close, .modal-background').on('click', function() {
  $('.modal').fadeOut(500)
  return false
})