//= require jquery
//= require jquery_ujs
//= require underscore
//= require gmaps/google

function show_gmap(markersHash) {
  handler = Gmaps.build('Google');
  handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
    markers = handler.addMarkers(markersHash);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
    handler.getMap().setZoom(7);
  });
}
