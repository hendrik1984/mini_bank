import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="transaction-type"
export default class extends Controller {
  static targets = ["transactionType", "recipient"]

  connect() {
    this.toggleRecipient()
    // console.log("connected to transaction-type controller")
    // console.log(this.transactionTypeTarget.value)
  }

  toggleRecipient() {
    const type = this.transactionTypeTarget.value
    const showRecipient = ["transfer"].includes(type)
    console.log("change to:", this.transactionTypeTarget.value)
    console.log(showRecipient)

    this.recipientTarget.style.display = showRecipient ? "block" : "none"
  }
}
