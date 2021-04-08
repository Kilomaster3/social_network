import { Loader } from "@googlemaps/js-api-loader"
require('dotenv').config();

const loader = new Loader({
  apiKey:  'AIzaSyAdSbhAg9dc8BC2yztYHcBi7D6_v6-0Rfg',
  version: "weekly",
  ...{},
});

loader.load().then(() => {
  const map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 34.84555, lng: -111.8035 },
    zoom: 10,
  });
  const tourStops = [
    [{ lat: gon.locations[0].latitude, lng: gon.locations[0].longitude }, "Bell Rock"],
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
