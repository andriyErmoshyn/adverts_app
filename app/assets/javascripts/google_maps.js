function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 12,
    center: {lat: 49.236819, lng: 28.455170}
  });
  var geocoder = new google.maps.Geocoder();  
 
  $("#new_member, form.edit_member").change(function(){
    geocodeAddress(geocoder, map)
  });
  $(function(){
    geocodeAddress(geocoder, map)
  });  
}

function geocodeAddress(geocoder, resultsMap) {
  // location for profile page
  var location = $('#location').html();
  //location from sign up and edit profile form
  var memberAddress = $('#member_address').val() || 0,
        city = $('#member_city').val() || 0,
        state = $('#member_state').val() || 0,
        country = $('#member_country').val() || 0,
        zip = $('#member_zip').val() || 0;

  if(memberAddress.length>0 && city.length>0 && state.length>0 && 
     country.length>0 && zip.length>0){
    var addressFromForm = memberAddress + ' ' + city + ' ' + state +' ' + country + ' ' + zip;
  }
  
  var address = location || addressFromForm;
  geocoder.geocode({'address': address}, function(results, status) {
    resultsMap.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
        map: resultsMap,
        position: results[0].geometry.location
      });    
  });
}
