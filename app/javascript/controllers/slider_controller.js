import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {

  // # which targets do we need?
  // We need item targets for sure
  // we also need a class we can toggle to show or hide the elements

  static targets = ['item']

  // defining a target provides 3 methods, itemTarget, itemTargets, hasItemTarget

  // runs only once when controller is instantiated
  initialize() {
    this.index = 0
    this.showItem()
  }

  // # this runs everytime the controller instance is connected to DOM
  connect() {

  }

  // every time the controller instance is removed from dom
  disconnect() {

  }

  prev() {
    if (this.index > 0) {
       this.index--
    } else {
      this.index = this.itemTargets.length - 1
    }

    this.showItem()
  }

  next() {
    if (this.index < this.itemTargets.length - 1) {
      this.index++
    } else{
      this.index = 0
    }

    this.showItem()
  }


  showItem() {
    console.log("Hey")
    console.log(this.index)
    this.itemTargets.forEach((item, idx) => {
      item.hidden = (idx !== this.index)
    })
  }
}
