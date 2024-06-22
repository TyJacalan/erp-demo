import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tasks-form"
export default class extends Controller {
  static targets = ["container", "formItem"];

  connect() {
    const taskCount = sessionStorage.getItem("taskCount");
    if (taskCount) {
      for (let i = this.formItemTargets.length; i < taskCount; i++) {
        this.addTask();
      }
    }
  }

  addTask(event) {
    if (event) event.preventDefault();

    const index = this.formItemTargets.length;
    const newRow = this.formItemTargets[this.formItemTargets.length - 1].cloneNode(true);

    // Update the name attributes for the new row
    newRow.querySelectorAll('input, select').forEach(input => {
      input.name = input.name.replace(/\d+/, index);
      input.id = input.id.replace(/\d+/, index);
      input.classList.remove('error');
    });

    // Clear any previous error messages
    newRow.querySelectorAll('.text-destructive').forEach(errorMsg => {
      errorMsg.textContent = '';
    });

    this.containerTarget.appendChild(newRow);
    sessionStorage.setItem("taskCount", this.formItemTargets.length);
  }

  removeTask(event) {
    event.preventDefault();
    if (this.formItemTargets.length > 1) {
      const taskElement = event.target.closest("[data-tasks-form-target='formItem']");
      if (taskElement) {
        taskElement.remove();
        this.updateIndices();
        sessionStorage.setItem("taskCount", this.formItemTargets.length);
      }
    }
  }

  updateIndices() {
    this.formItemTargets.forEach((formItem, index) => {
      formItem.querySelectorAll('input, select').forEach(input => {
        input.name = input.name.replace(/\d+/, index);
      });
    });
  }

  updateSelectOnChange(event) {
    const input = event.target;

    if (input) {
      const option = input.querySelector(`option[value="${input.value}"]`);
      if (option) {
        // Set all options to not selected
        input.querySelectorAll('option').forEach(opt => opt.removeAttribute('selected'));
        // Set the matched option to selected
        option.setAttribute('selected', 'selected');
      } else {
        // Reset to default if no matching option found
        input.value = 'default';
      }
    }
  }
}
