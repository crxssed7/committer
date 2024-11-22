import { Controller } from "@hotwired/stimulus";
import AirDatepicker from "air-datepicker";
import localeEn from "air-datepicker/locale/en";

// Connects to data-controller="date-picker"
export default class extends Controller {
  static values = { date: String };

  connect() {
    new AirDatepicker(this.element, {
      locale: localeEn,
      selectedDates: [this.dateValue],
      position: "bottom left",
      onSelect: (selection) => {
        const newDate = this.formatDateToParamString(selection.date);
        const url = new URL(window.location.href);
        url.searchParams.set("date", newDate);
        window.location.href = url.toString();
      },
      dateFormat: (date) => {
        const options = {
          weekday: "long",
          year: "numeric",
          month: "long",
          day: "numeric",
        };
        return date.toLocaleDateString("en-US", options);
      },
    });
  }

  formatDateToParamString(date) {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, "0"); // Months are 0-indexed
    const day = String(date.getDate()).padStart(2, "0");
    return `${year}-${month}-${day}`;
  }
}
