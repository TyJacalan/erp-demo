import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ui--carousel"
export default class extends Controller {
  static targets = [ 'slide', 'nextButton', 'prevButton']
  static values = { index: Number }

  initialize() {
    this.showCurrentSlide()
  }

  next() {
    this.indexValue++
    this.showCurrentSlide()
  }

  previous() {
    this.indexValue--
    this.showCurrentSlide()
  }

  showCurrentSlide() {
    this.slideTargets.forEach((element, index) => {
      element.hidden = index !== this.indexValue
    })

    if (this.indexValue === 0) {
      this.prevButtonTarget.hidden = true
      this.prevButtonTarget.disabled = true
    } else {
      this.prevButtonTarget.hidden = false
      this.prevButtonTarget.disabled = false
    }

    if (this.indexValue === this.slideTargets.length - 1) {
      this.nextButtonTarget.hidden = true
      this.nextButtonTarget.disabled = true
    } else {
      this.nextButtonTarget.hidden = false
      this.nextButtonTarget.disabled = false
    }
  }
}
