import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import styled from 'styled-components';

const Container = styled('div')`
  right: 0px;
  position: absolute;
  z-index: 10;
  height: 100%;
  background: #FFFFFF;
`;

const picker = document.getElementById("booking_amount");
const guest_count = document.getElementById("guest_count");
const booking_guests = document.getElementById("booking_guests");

export default class GuestPicker extends Component {
  constructor(){
    super();
    this.state = {
      clicked : false,
      position : 1,
      visible: false,
      total_count: 0,
      adult_count: 0,
      child_count: 0
    }

    this.addAdult = this.addAdult.bind(this);
    this.subtractAdult = this.subtractAdult.bind(this);
    this.subtractChild = this.subtractChild.bind(this);
    this.addChild = this.addChild.bind(this);
    this.closeContainer = this.closeContainer.bind(this);
  }

  closeContainer (event) {
    event.preventDefault();
    this.setState(prevState => ({
      visible: !prevState.visible
    }));
    guest_count.textContent = this.state.adult_count + this.state.child_count + " guests";
    booking_guests.value = "{\"child_count\": \"" + this.state.child_count + "\"" + ", " + "\"adult_count\": \"" + this.state.adult_count + "\"}";
  }

  componentDidMount() {
    picker.addEventListener("click", () => {
      this.setState(prevState => ({
        visible: !prevState.visible
      }));
    })
  }
  
  addAdult(event) {
    event.preventDefault();
    this.setState({ adult_count: this.state.adult_count +=  1 });
  }

  subtractAdult(event) { 
    event.preventDefault();
    this.setState({ adult_count: this.state.adult_count -=  1 });
  }

  addChild(event) {
    event.preventDefault();
    this.setState({ child_count: this.state.child_count +=  1 });
  }

  subtractChild(event) {
    event.preventDefault();
    this.setState({ child_count: this.state.child_count -=  1 });
  }

  render(){
    return(
      <Container className={ this.state.visible  ? 'guestpicker-visible' : 'guestpicker-hidden' }>
        <div className="card p-5">
          <div className="adult">
            <div>
              <span className="is-bold is-size-4"> Adult </span>
              <p> +200 zł for more than 2 adults  </p>
            </div>
            <div className="center-buttons">
              <button
                onClick = { this.subtractAdult }
                type="button" 
                aria-label="subtract"
                disabled={this.state.adult_count === 0 ? true : false } 
                className={this.state.adult_count === 0 ? "update__buttons update__buttons-disabled" : "update__buttons"}>
                <span>
                  <svg className="update__buttons-minus" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="presentation" focusable="false" >
                    <path d="m2 16h28"></path>
                  </svg>
                </span>
              </button>
              <span className="ml-2 mr-2"> { this.state.adult_count } </span>
              <button
                onClick = { this.addAdult }
                type="button" 
                disabled={(this.state.adult_count + this.state.child_count === 4) ? true : false}
                className={this.state.adult_count + this.state.child_count === 4 ? "update__buttons update__buttons-disabled" : "update__buttons"}
                aria-label="add">
                <span>
                  <svg className="update__buttons-add" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="presentation" focusable="false">
                    <path d="m2 16h28m-14-14v28">  
                    </path>
                  </svg>
                </span>
              </button>
            </div>
          </div>

          <div className="child  mt-5">
            <div>
              <span className="is-bold is-size-4"> Children </span>
              <p> Age 2-12 </p>
            </div>
            <div className="center-buttons">
              <button
                onClick = { this.subtractChild }
                type="button" 
                aria-label="subtract"
                disabled={ (this.state.child_count === 0) ? true : false } 
                className={ this.state.child_count === 0 ? "update__buttons update__buttons-disabled" : "update__buttons"}>
                <span>
                  <svg className="update__buttons-minus" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="presentation" focusable="false" >
                    <path d="m2 16h28"></path>
                  </svg>
                </span>
              </button>
              <span className="ml-2 mr-2"> { this.state.child_count } </span>
              <button
                onClick = { this.addChild }
                type="button" 
                disabled={(this.state.child_count + this.state.adult_count === 4) ? true : false}
                className={this.state.child_count + this.state.adult_count === 4 ? "update__buttons update__buttons-disabled" : "update__buttons"}
                aria-label="add">
                <span>
                  <svg className="update__buttons-add" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="presentation" focusable="false">
                    <path d="m2 16h28m-14-14v28">  
                    </path>
                  </svg>
                </span>
              </button>
            </div>
          </div>
          <hr />
          <p> <strong> Note: </strong> Maximum of 4 guests allowed </p>
          <button 
            className="button is-danger" 
            style={{float: 'right'}}
            onClick={this.closeContainer}
          > Close </button>
        </div>
      </Container>
    )
  }
}

document.addEventListener('turbolinks:load', () => {
  ReactDOM.render(
    <GuestPicker />,
    document.querySelectorAll("#guestpicker")[0].appendChild(document.createElement('div'))
  )

  ReactDOM.render(
    <GuestPicker />,
    document.querySelectorAll("#guestpicker")[1].appendChild(document.createElement('div'))
  )
})
