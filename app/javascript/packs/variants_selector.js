document.addEventListener("DOMContentLoaded", function(event) {
  const chevrons = document.querySelectorAll(".chevron-spin");
  console.log(chevrons)

  chevrons.forEach((button) => {
    button.addEventListener("click", (event) => {
      event.preventDefault();
      document.querySelector("div#" + event.currentTarget.id).classList.toggle("is-visible")
    })
  });
});