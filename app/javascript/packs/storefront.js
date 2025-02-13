window.onscroll = (event) =>  {
  var top =   window.pageYOffset || document.documentElement.scrollTop;
  let nodes = document.querySelectorAll("nav");
  let nav = nodes[nodes.length - 1];

  let navsearch = document.querySelectorAll("#searchnav");

  navsearch.forEach((n) => {
    n.style.opacity = top / 100;
  })
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

