import { Loader } from "@googlemaps/js-api-loader"
require('dotenv').config();

$(document).on('turbolinks:load', function() {

const loader = new Loader({
  apiKey:  'AIzaSyAdSbhAg9dc8BC2yztYHcBi7D6_v6-0Rfg',
  version: "weekly",
  ...{},
});

  loader.load().then(() => {
    const map = new google.maps.Map(document.getElementById("map"), {
      center: {lat: 53.90339315536, lng: 27.56036829948},
      zoom: 12,
    });

    const currentLocation = [
      [{
        lat: gon.locations[2].latitude,
        lng: gon.locations[2].longitude
      }, "Admin Admin"]
    ];

    $(function () {
      $('[name="tour"]').on('change', filterMarkers);
    });

    function filterMarkers(event) {
      if (event.currentTarget.value === 'online') {
        const infoWindow = new google.maps.InfoWindow();
        let Online = [{}];

        $.ajax({
          type: 'GET',
          dataType: 'json',
          url: '/account_interests/online',
          success: data => {
            let accountLocation;
            Online = data.map(item => {
              accountLocation = gon.locations.filter(tempLocation => tempLocation.id === item.account_id)[0];
              item['lat'] = accountLocation.latitude;
              item['lng'] = accountLocation.longitude;
              return item;
            });

            Online.forEach(account => {
              let position = {
                lat: account.lat,
                lng: account.lng
              };

              let markerOnline = new google.maps.Marker({
                position,
                map,
                draggable: true,
                title: account.full_name_path,
                optimized: false,
                icon: 'http://maps.google.com/mapfiles/ms/icons/red-dot.png'
              });
              markerOnline.addListener("click", () => {
                infoWindow.close();
                infoWindow.setContent(markerOnline.getTitle());
                infoWindow.open(markerOnline.getMap(), markerOnline);
              });
            });
          }
        });
      } else if (event.currentTarget.value === 'connection') {
        const infoWindow = new google.maps.InfoWindow();
        let Connection = [{}];

        $.ajax({
          type: 'GET',
          dataType: 'json',
          url: '/account_interests/connection',
          success: data => {
            let accountLocation;
            Connection = data.map(item => {
              accountLocation = gon.locations.filter(tempLocation => tempLocation.id === item.account_id)[0];
              item['lat'] = accountLocation.latitude;
              item['lng'] = accountLocation.longitude;
              return item;
            });

            Connection.forEach(account => {
              let position = {
                lat: account.lat,
                lng: account.lng
              };

              let markerConnection = new google.maps.Marker({
                position,
                map,
                draggable: true,
                title: account.full_name_path,
                optimized: false,
                icon: 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png'
              });
              markerConnection.addListener("click", () => {
                infoWindow.close();
                infoWindow.setContent(markerConnection.getTitle());
                infoWindow.open(markerConnection.getMap(), markerConnection);
              });
            });
          }
        });
      } else if (event.currentTarget.value === 'max connection') {
        const infoWindow = new google.maps.InfoWindow();
        let MaxConnection = [{}];

        $.ajax({
          type: 'GET',
          dataType: 'json',
          url: '/account_interests/max_connection',
          success: data => {
            let accountLocation;
            MaxConnection = data.map(item => {
              accountLocation = gon.locations.filter(tempLocation => tempLocation.id === item.account_id)[0];
              item['lat'] = accountLocation.latitude;
              item['lng'] = accountLocation.longitude;
              return item;
            });

            MaxConnection.forEach(account => {
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
                icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png'
              });
              markerMaxConnection.addListener("click", () => {
                infoWindow.close();
                infoWindow.setContent(markerMaxConnection.getTitle());
                infoWindow.open(markerMaxConnection.getMap(), markerMaxConnection);
              });
            });
          }
        });
      } else if (event.currentTarget.value === 'current location') {
        const infoWindow = new google.maps.InfoWindow();
        let CurrentLocation = [{}];

        $.ajax({
          type: 'GET',
          dataType: 'json',
          url: '/account_interests/current_location',
          success: data => {
            let accountLocation;
            CurrentLocation = data.map(item => {
              accountLocation = gon.locations.filter(tempLocation => tempLocation.id === item.account_id)[0];
              item['lat'] = accountLocation.latitude;
              item['lng'] = accountLocation.longitude;
              return item;
            });

            CurrentLocation.forEach(account => {
              let position = {
                lat: account.lat,
                lng: account.lng
              };

              let markerCurrentLocation = new google.maps.Marker({
                position,
                map,
                draggable: true,
                title: account.full_name_path,
                optimized: false,
                icon: 'http://maps.google.com/mapfiles/ms/icons/yellow-dot.png'
              });

              markerCurrentLocation.addListener("click", () => {
                infoWindow.close();
                infoWindow.setContent(markerCurrentLocation.getTitle());
                infoWindow.open(markerCurrentLocation.getMap(), markerCurrentLocation);
              });
            });
          }
        });
      }
    }
  });
});
