import { Loader } from "@googlemaps/js-api-loader"
require('dotenv').config();

const loader = new Loader({
  apiKey:  'AIzaSyAdSbhAg9dc8BC2yztYHcBi7D6_v6-0Rfg',
  version: "weekly",
  ...{},
});

loader.load().then(() => {
  const map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 53.90339315536, lng: 27.56036829948 },
    zoom: 10,
  });
  const tourStops = [
    [{ lat: gon.locations[0].latitude, lng: gon.locations[0].longitude }, "Bell Rock"],
    [{ lat: gon.locations[1].latitude, lng: gon.locations[1].longitude }, "AMG"],
  ];
  const infoWindow = new google.maps.InfoWindow();
  tourStops.forEach(([position, title], i) => {
    const marker = new google.maps.Marker({
      position,
      map,
      draggable: true,
      title: `${i + 1}. ${title}`,
      optimized: false,
    });
    marker.addListener("click", () => {
      infoWindow.close();
      infoWindow.setContent(marker.getTitle());
      infoWindow.open(marker.getMap(), marker);
    });
  });
});
