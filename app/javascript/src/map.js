import { Loader } from "@googlemaps/js-api-loader"
require('dotenv').config();

const loader = new Loader({
  apiKey:  'AIzaSyAdSbhAg9dc8BC2yztYHcBi7D6_v6-0Rfg',
  version: "weekly",
  ...{},
});

loader.load().then(() => {
  const map = new google.maps.Map(document.getElementById("map"), {
    center: {lat: 53.90339315536, lng: 27.56036829948},
    zoom: 10,
  });

  const Online = [
    [{
      lat: gon.locations[0].latitude,
      lng: gon.locations[0].longitude
    }, "Rufina Hintz"],
    [{
      lat: gon.locations[1].latitude,
      lng: gon.locations[1].longitude
    }, "Alex Hrom"],
  ];

  const Connection = [
    [{
      lat: gon.locations[0].latitude,
      lng: gon.locations[0].longitude
    }, "Vladislas Zavodski 50 %"]
  ];

  $(function () {
    $('[name="tour"]').on('change', filterMarkers);
  });

  function filterMarkers(event) {
    if (event.target.value === 'online') {
      const infoWindow = new google.maps.InfoWindow();

      Online.forEach(([position, title], i) => {
        let marker = new google.maps.Marker({
          position,
          map,
          draggable: true,
          title: `${i + 1}. ${title}`,
          optimized: false,
          icon: 'http://maps.google.com/mapfiles/ms/icons/red-dot.png'
        });
        marker.addListener("click", () => {
          infoWindow.close();
          infoWindow.setContent(marker.getTitle());
          infoWindow.open(marker.getMap(), marker);
        });
      });
    } else if (event.target.value === 'max connection') {
      const infoWindow = new google.maps.InfoWindow();
      let maxConnection = [{}];

      $.ajax({
        type: 'GET',
        dataType: 'json',
        url: '/account_interests/max_connection',
        success: data => {
          let accountLocation;
          maxConnection = data.map(item => {
            accountLocation = gon.locations.filter(tempLocation => tempLocation.id === item.account_id)[0];
            item['lat'] = accountLocation.latitude;
            item['lng'] = accountLocation.longitude;
            return item;
          });

          maxConnection.forEach(account => {
            let position = {
              lat: account.lat,
              lng: account.lng
            };

            let markerMaxConnection = new google.maps.Marker({
              position,
              map,
              draggable: true,
              title: account.full_name_path,
              optimized: false,
              icon: 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png'
            });
            markerMaxConnection.addListener("click", () => {
              infoWindow.close();
              infoWindow.setContent(markerMaxConnection.getTitle());
              infoWindow.open(markerMaxConnection.getMap(), markerMaxConnection);
            });
          });
        }
      });
    } else if (event.target.value === 'connection') {
      const infoWindow = new google.maps.InfoWindow();

      Connection.forEach(([position, name], title) => {
        let markerConnection = new google.maps.Marker({
          position,
          map,
          draggable: true,
          title: `${title + 1}. ${name}`,
          optimized: false,
          icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png'
        });
        markerConnection.addListener("click", () => {
          infoWindow.close();
          infoWindow.setContent(markerConnection.getTitle());
          infoWindow.open(markerConnection.getMap(), markerConnection);
        });
      });
    }
  }
});
