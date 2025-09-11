import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {

  // # which targets do we need?
  // We need item targets for sure
  // we also need a class we can toggle to show or hide the elements

  static targets = ['item']

  static values = { index: Number }

  // defining a target provides 3 methods, itemTarget, itemTargets, hasItemTarget

  // runs only once when controller is instantiated
  initialize() {
    // this.indexValue = 0
    // now we don't need to set the default value because we get it from stimulus on load
    this.showItem()

  }

  // # this runs everytime the controller instance is connected to DOM
  connect() {
    console.log(this.indexValue)
    console.log(typeof this.indexValue)
  }

  // every time the controller instance is removed from dom
  disconnect() {

  }


  // # we update methods to use indexValue not index

  prev() {
    if (this.indexValue > 0) {
       this.indexValue--
    } else {
      this.indexValue = this.itemTargets.length - 1
    }

    this.showItem()
  }

  next() {
    if (this.indexValue < (this.itemTargets.length - 1)) {
      this.indexValue++
    } else{
      this.indexValue = 0
    }

    this.showItem()
  }


  showItem() {
    console.log("The index is " + this.indexValue)
    this.itemTargets.forEach((item, idx) => {
      item.hidden = (idx !== this.indexValue)
    })
  }
}
