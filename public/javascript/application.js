
$(document).ready(function() {

	$('.btn-toggle').click(function() {
	    $(this).find('.btn').toggleClass('active');  
	    
	    if ($(this).find('.btn-default').size()>0) {
	    	$(this).find('.btn').toggleClass('btn-default');
	    }
	    if ($(this).find('.btn-danger').size()>0) {
	    	$(this).find('.btn').toggleClass('btn-danger');
	    }
	    if ($(this).find('.btn-success').size()>0) {
	    	$(this).find('.btn').toggleClass('btn-success');
	    }
	    if ($(this).find('.btn-info').size()>0) {
	    	$(this).find('.btn').toggleClass('btn-info');
	    }
	    
	    $(this).find('.btn').toggleClass('btn-primary');
    });


$('#exampleModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget) // Button that triggered the modal
  var recipient = button.data('whatever') // Extract info from data-* attributes
  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
  var modal = $(this)
  // modal.find('.modal-title').text('New message to ' + recipient)
  modal.find('.modal-body input').val(recipient)
});



percent = $('.bar2 div span').html();
total = $('.bar2').attr('data-total2');
percentStart = 0;


percent2 = $('.bar3 div span').html();
total2 = $('.bar3').attr('data-total3');
percentStart2 = 0;


setInterval(function() {
  $('.show3').css('height',percentStart2/total2*100+'%');
  $('.bar3').css('height',percentStart2/total2*100+'%');
  $('.bar3 div span').html(percentStart2);
  if(percentStart2<percent2) {percentStart2=percentStart2+5;}
},1);





setInterval(function() {
  $('.show2').css('height',percentStart/total*100+'%');
  $('.bar2').css('height',percentStart/total*100+'%');
  $('.bar2 div span').html(percentStart);
  if(percentStart<percent) {percentStart=percentStart+5;}
},1);





setInterval(function() {
    $('.blink_me').fadeOut(800);
    $('.blink_me').fadeIn(800);
}, 200);


	$("#HEART").click(function(event){
		var current_img_source = $("#animal_image")[0].src;
		current_img_source = current_img_source.split("/");
		event.preventDefault();
		$.ajax({
			type: "POST",
			data: {img_folder:current_img_source[current_img_source.length-2], img:current_img_source[current_img_source.length-1]},
			url: "/photos/get_cute_image",
			success: function(data){
				console.log(data);
				var image = '/images/'+data[0].animal_type+'/'+data[0].photo_link+'.jpg';
				 $("#animal_image").attr('src',image);
				 document.getElementById("PHOTO_NAME").innerHTML= data[1];
				 document.getElementById("PHOTO_UPVOTE").innerHTML= data[2];
				 document.getElementById("PHOTO_DOWNVOTE").innerHTML= data[3];
			}
		});
	});
	$("#NOTHEART").click(function(event){
		var current_img_source = $("#animal_image")[0].src;
		current_img_source = current_img_source.split("/");
		event.preventDefault();
		$.ajax({
			type: "POST",
			data: {img_folder:current_img_source[current_img_source.length-2], img:current_img_source[current_img_source.length-1]},
			url: "/photos/get_not_cute_image",
			success: function(data){
				console.log(data);
				var image = '/images/'+data[0].animal_type+'/'+data[0].photo_link+'.jpg';
				 $("#animal_image").attr('src',image);
				  document.getElementById("PHOTO_NAME").innerHTML= data[1];
				 document.getElementById("PHOTO_UPVOTE").innerHTML= data[2];
				 document.getElementById("PHOTO_DOWNVOTE").innerHTML= data[3];
			}
		});
	});
	$("#DELETE").click(function(){
		var current_img_source = $('#GENERALPHOTO').children().attr("id");
		event.preventDefault();
		$.ajax({
			type: "POST",
			data: {img: current_img_source},
			url: "/photos/get_delete_image",
			success: function(data){
				var image = '/images/'+data.animal_type+'/'+data.photo_link+'.jpg';
				 $("#animal_image").attr('src',image);
			}
		});
	});
	$("#CAT").click(function(event){
		console.log("CAT");
		event.preventDefault();
		$.ajax({
			type: "POST",
			data: {animal: "cat"},
			url: "/photos/get_category",
			success: function(data){
				console.log(data);
				var image = '/images/'+data[0].animal_type+'/'+data[0].photo_link+'.jpg';
				 $("#animal_image").attr('src',image);
				 document.getElementById("PHOTO_NAME").innerHTML= data[1];
				 document.getElementById("PHOTO_UPVOTE").innerHTML= data[2];
				 document.getElementById("PHOTO_DOWNVOTE").innerHTML= data[3];

			}
		});
	});
	$("#DOG").click(function(event){
		console.log("DOG");
		event.preventDefault();
		$.ajax({
			type: "POST",
			data: {animal: "dog"},
			url: "/photos/get_category",
			success: function(data){
				console.log(data);
				var image = '/images/'+data[0].animal_type+'/'+data[0].photo_link+'.jpg';
				 $("#animal_image").attr('src',image);
				 document.getElementById("PHOTO_NAME").innerHTML= data[1];
				 document.getElementById("PHOTO_UPVOTE").innerHTML= data[2];
				 document.getElementById("PHOTO_DOWNVOTE").innerHTML= data[3];
			}
		});
	});

});
