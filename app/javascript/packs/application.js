require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("trix")
require("@rails/actiontext")

window.onscroll = (event) =>  {
  var top =   window.pageYOffset || document.documentElement.scrollTop;
  let nav = document.querySelector("nav");
  document.querySelector("#searchnav").style.opacity = top / 100;
  var hero = document.querySelector("#herosearch");
  if(hero) {
    hero.style.opacity = 1 - (top / 100);
  }

  if(top > 100) {
    nav.classList.add("white__nav");
  } else {
    nav.classList.remove("white__nav");
  }
};

document.addEventListener("turbolinks:load", () => {
  const $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);
  if ($navbarBurgers.length > 0) {
    $navbarBurgers.forEach( el => {
      el.addEventListener('click', () => {
        const target = el.dataset.target;
        const $target = document.getElementById(target);

        el.classList.toggle('is-active');
        $target.classList.toggle('is-active');

      });
    });
  }
});
