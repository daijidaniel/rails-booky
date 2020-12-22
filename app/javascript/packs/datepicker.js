import bulmaCalendar from "bulma-calendar/dist/js/bulma-calendar.min.js";

var host = "https://kimuraglamping.pl"
// var host = "http://localhost:3000"
document.addEventListener("turbolinks:load", function(event) {
  // var booked_dates = resp.map((d) => new Date(d));
  // console.log(booked_dates);
  var unit_id = document.querySelector("#current_unit").dataset['unitId'];

  fetchDates(host + "/available_dates/" + unit_id)

  const request = async (url) => {
    const response = await fetch(url);
    const json = await response.json();
    console.log(json);
  }

  async function fetchDates(url) {
    const response = await fetch(url, {
      method: 'GET',
      mode: 'same-origin',
      cache: 'no-cache',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json'
      },
      redirect: 'follow',
      referrerPolicy: 'no-referrer',
    }).then(response => response.json())
    .then((json) => {
      const calendars = bulmaCalendar.attach('[type="date"]', {
        type: "date",
        isRange: "true",
        color: "purple-100",
        labelFrom: "Check In",
        labelTo: "Check Out",
        minDate: "05/01/2021",
        maxDate: "10/20/2021",
        enableYearSwitch: false,
        allowSameDayRange: false,
        disabledDates: json.map((j) => { return new Date(j) }),
        lang: "pl",
        dateFormat: "DD/MM/YYYY"
      });

      // Loop on each calendar initialized
      calendars.forEach(calendar => {
        // Add listener to select event
        calendar.on('select', date => {
          console.log(date);
        });
        // calendar.show();
      });

      // To access to bulmaCalendar instance of an element
      const element = document.querySelector('#my-element');
      if (element) {
        // bulmaCalendar instance is available as element.bulmaCalendar
        element.bulmaCalendar.on('select', datepicker => {
          console.log(datepicker.data.value());
        });
      }
    });
  }
});