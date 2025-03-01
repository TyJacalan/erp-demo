import { Controller } from "@hotwired/stimulus";

export default class UIDialog extends Controller {
  static targets = [
    "dialog",
    "modal",
    "focus",
    "drag",
    "backdrop",
    "closeButton",
  ];
  static actions = [
    ["element", "keydown@window->closeByKey"],
    ["modal", "click->closeByModal"],
    ["closeButton", "click->close"],
  ];

  initialize() { }
  connect() { }
  open(e) {
    this.openBy(e.target);
    e.preventDefault();
  }

  close(e) {
    this.closeBy(e.target);
    e.preventDefault();
  }

  toggle(e) {
    if (this.isVisible()) {
      this.closeBy(e.target);
    } else {
      this.openBy(e.target);
    }
    e.preventDefault();
  }

  closeByKey(e) {
    if (e.keyCode == 27) {
      this.closeBy(e.target);
      e.preventDefault();
    }
  }

  closeByModal(e) {
    if (!this.dialogTarget.contains(e.target)) {
      this.closeBy(e.target);
    }
  }

  isVisible() {
    return this.dialogTarget.classList.contains("st-dialog--visible");
  }

  openBy(target) {
    this.toggleClass(true);

    if (this.hasFocusTarget) {
      this.focusTarget.focus();
    }

    this.dispatch("opened", { detail: { target: target } });
  }

  closeBy(target) {
    this.toggleClass(false);

    this.dispatch("closed", { detail: { target: target } });
  }

  // Refactor Me
  // This needs to be combined with the toggle method in sheet_controller
  toggleClass(visible) {
    if (visible) {
      this.dialogTarget.classList.remove("hidden");
      this.dialogTarget.dataset.state = "open";
      if (this.hasBackdropTarget) {
        this.backdropTarget.classList.remove("hidden");
        this.backdropTarget.dataset.state = "open";
      }
      if (this.hasModalTarget) {
        this.modalTarget.classList.remove("hidden");
        this.modalTarget.dataset.state = "open";
      }
    } else {
      this.dialogTarget.classList.add("hidden");
      this.dialogTarget.dataset.state = "closed";
      if (this.hasBackdropTarget) {
        this.backdropTarget.classList.add("hidden");
        this.backdropTarget.dataset.state = "closed";
      }
      if (this.hasModalTarget) {
        this.modalTarget.classList.add("hidden");
        this.modalTarget.dataset.state = "closed";
      }
    }
  }
}
