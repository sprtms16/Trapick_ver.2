//Category Click Event
	$(function() {
	      $('#restList').hide();
	      $('#hotelList').hide();
	      $('#tab-1').addClass('selected');
	   });

	   $(function() {

	      $('#tab-2').click(function() {
	         $('#restList').show();
	         $('#hotelList').hide();
	         $('#itemList').hide();
	         $('#tab-1').removeClass('selected');
	         $('#tab-2').addClass('selected');
	         $('#tab-3').removeClass('selected');

	      });
	   });

	   $(function() {

	      $('#tab-3').click(function() {
	         $('#hotelList').show();
	         $('#itemList').hide();
	         $('#restList').hide();
	         $('#tab-1').removeClass('selected');
	         $('#tab-2').removeClass('selected');
	         $('#tab-3').addClass('selected');
	      });
	   });

	   $(function() {

	      $('#tab-1').click(function() {
	         $('#itemList').show();
	         $('#hotelList').hide();
	         $('#restList').hide();
	         $('#tab-1').addClass('selected');
	         $('#tab-2').removeClass('selected');
	         $('#tab-3').removeClass('selected');
	      });
	   });
