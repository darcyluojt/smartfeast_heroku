import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["ingredients", "steps", "ingredientsTab", "stepsTab"]
  toggle(event){
    event.preventDefault();
    console.log("event.target:", event.target);
    this.ingredientsTabTarget.classList.toggle("hidden");
    this.stepsTabTarget.classList.toggle("hidden");
  }
}
