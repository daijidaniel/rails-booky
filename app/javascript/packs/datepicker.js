import bulmaCalendar from "bulma-calendar/dist/js/bulma-calendar.min.js";

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
  disabledDates: [],
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