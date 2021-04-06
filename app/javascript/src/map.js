import { Loader } from "@googlemaps/js-api-loader"
require('dotenv').config();

const loader = new Loader({
  apiKey:  'AIzaSyAdSbhAg9dc8BC2yztYHcBi7D6_v6-0Rfg',
  version: "weekly",
  ...{},
});

console.log(process.env);

loader.load().then(() => {
  const map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 34.84555, lng: -111.8035 },
    zoom: 10,
  });
  const tourStops = [
    [{ lat: 34.8791806, lng: -111.8265049 }, "Boynton Pass"],
    [{ lat: 34.8559195, lng: -111.7988186 }, "Airport Mesa"],
    [{ lat: 34.832149, lng: -111.7695277 }, "Chapel of the Holy Cross"],
    [{ lat: 34.823736, lng: -111.8001857 }, "Red Rock Crossing"],
    [{ lat: 34.800326, lng: -111.7665047 }, "Bell Rock"],
  ];
  const infoWindow = new google.maps.InfoWindow();
  tourStops.forEach(([position, title], i) => {
    const marker = new google.maps.Marker({
      position,
      map,
      title: `${i + 1}. ${title}`,
      label: `${i + 1}`,
      optimized: false,
    });
    marker.addListener("click", () => {
      infoWindow.close();
      infoWindow.setContent(marker.getTitle());
      infoWindow.open(marker.getMap(), marker);
    });
  });
});
