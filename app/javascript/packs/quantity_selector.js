const quantities = document.querySelectorAll("[data-quantity-modal='quantity']");

quantities.forEach((element) => {
  var minus = minus_button();
  var plus = plus_button();
  var size = 0;

  element.parentElement.insertBefore(minus, element);
  element.parentElement.appendChild(plus);
  element.value = element.value || size;

  minus.addEventListener("click", (event) => {
    event.preventDefault()
    if (element.value == 0) {
    } else {
      element.value -= 1;
    }
  });

  plus.addEventListener("click", (event) => {
    event.preventDefault()
    var x = parseInt(element.value)
    x += 1;
    element.value = x;
  });
});

function plus_button() {
  var xmlns = "http://www.w3.org/2000/svg";
  const button = document.createElement('button');
  const span = document.createElement('span');
  var svg = document.createElementNS(xmlns, "svg");
  const path = document.createElementNS(xmlns, 'path');

  button.setAttribute("class", "democlass");
  setAttributes(button, {
    "type": "button", 
    "aria-label": "add", 
    "class": "update__buttons" 
  });

  setAttributes(svg, {
    "class": "update__buttons-add", 
    "viewBox": "0 0 32 32", 
    "xmlns": "http://www.w3.org/2000/svg",
    "aria-hidden": "true",
    "role": "presentation",
    "focusable": "false"
  });
  
  setAttributes(path, {
    "d": "m2 16h28m-14-14v28"
  });

  svg.appendChild(path);
  span.appendChild(svg);
  button.appendChild(span);

  return button;
}

function minus_button() {
  var xmlns = "http://www.w3.org/2000/svg";
  const button = document.createElement('button');
  const span = document.createElement('span');
  var svg = document.createElementNS(xmlns, "svg");
  const path = document.createElementNS(xmlns, 'path');

  button.setAttribute("class", "democlass");
  setAttributes(button, {
    "type": "button", 
    "aria-label": "subtract", 
    "class": "update__buttons" 
  });

  setAttributes(svg, {
    "class": "update__buttons-minus", 
    "viewBox": "0 0 32 32", 
    "xmlns": "http://www.w3.org/2000/svg",
    "aria-hidden": "true",
    "role": "presentation",
    "focusable": "false"
  });
  
  setAttributes(path, {
    "d": "m2 16h28"
  });

  svg.appendChild(path);
  span.appendChild(svg);
  button.appendChild(span);

  return button;
}

function setAttributes(el, attrs) {
  for(var key in attrs) {
    el.setAttribute(key, attrs[key]);
  }
}
