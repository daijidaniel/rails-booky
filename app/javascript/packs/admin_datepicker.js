import bulmaCalendar from "bulma-calendar/dist/js/bulma-calendar.min.js";

// var host = "https://kimuraglamping.pl"
var host = "http://localhost:3000"
var calendar;
var picker_spot = document.querySelector("#date_picker_here");
document.addEventListener("turbolinks:load", function(event) {

  var unit_id = document.querySelector("#unit").value;
  date_maker(unit_id);
  document.querySelector("#unit").addEventListener("change", function(event)  {
    var unit_id = document.querySelector("#unit").value;
    date_maker(unit_id);
  });
});

function date_maker(unit_id) {
  fetchDates(host + "/available_dates/" + unit_id);

  const request = async (url) => {
    const response = await fetch(url);
    const json = await response.json();
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
      if(picker_spot.childNodes[0]) {
        picker_spot.childNodes[0].remove();
        var new_calendar = document.createElement('input');
        new_calendar.setAttribute('id', "calendar_mount");
        new_calendar.setAttribute('type', "date");
        new_calendar.setAttribute('name', "booking[date]");
        new_calendar.setAttribute('class', "is-black");
        picker_spot.appendChild(new_calendar);
      }
      calendar = bulmaCalendar.attach('#calendar_mount', {
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
      })[0];
    });
  }
}