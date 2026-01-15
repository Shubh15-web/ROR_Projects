document.addEventListener('DOMContentLoaded', function() {
  const form = document.querySelector('#booking-form');
  const vehicleInput = document.querySelector('#booking_vehicle_license_plate');
  const startTimeInput = document.querySelector('#booking_start_time');
  const endTimeInput = document.querySelector('#booking_end_time');
  
  if (form) {
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      
      // Clear previous errors
      clearAllErrors();
      
      let isValid = true;
      
      // Vehicle Number validation
      if (!vehicleInput.value.trim()) {
        showError(vehicleInput, 'Please enter Vehicle Number');
        isValid = false;
      } else {
        // Vehicle number format validation
        const vehiclePattern = /^[A-Z]{2}[0-9]{1,2}[A-Z]{1,2}[0-9]{1,4}$/;
        if (!vehiclePattern.test(vehicleInput.value.toUpperCase())) {
          showError(vehicleInput, 'Please enter valid Vehicle Number (e.g., DL01AB1234)');
          isValid = false;
        }
      }
      
      // Parking Slot validation
      const selectedSlot = document.querySelector('input[name="booking[parking_slot_id]"]:checked');
      if (!selectedSlot) {
        showSlotError('Please select Parking Slot');
        isValid = false;
      }
      
      // Start Time validation
      if (!startTimeInput.value) {
        showError(startTimeInput, 'Please select Start Time');
        isValid = false;
      }
      
      // End Time validation (if provided, should be after start time)
      if (endTimeInput.value && startTimeInput.value) {
        const startTime = new Date(startTimeInput.value);
        const endTime = new Date(endTimeInput.value);
        if (endTime <= startTime) {
          showError(endTimeInput, 'End Time must be after Start Time');
          isValid = false;
        }
      }
      
      if (isValid) {
        form.submit();
      }
    });
  }
  
  function showError(input, message) {
    input.classList.add('is-invalid');
    let feedback = input.parentNode.querySelector('.invalid-feedback');
    if (!feedback) {
      feedback = document.createElement('div');
      feedback.className = 'invalid-feedback d-block';
      input.parentNode.appendChild(feedback);
    }
    feedback.textContent = message;
    feedback.style.display = 'block';
  }
  
  function showSlotError(message) {
    const slotsContainer = document.querySelector('.row.g-3.mt-2');
    let errorDiv = slotsContainer.parentNode.querySelector('.slot-error');
    if (!errorDiv) {
      errorDiv = document.createElement('div');
      errorDiv.className = 'alert alert-danger mt-2 slot-error';
      slotsContainer.parentNode.appendChild(errorDiv);
    }
    errorDiv.innerHTML = '<i class="fas fa-exclamation-triangle me-2"></i>' + message;
  }
  
  function clearAllErrors() {
    // Clear all input errors
    const inputs = [vehicleInput, startTimeInput, endTimeInput];
    inputs.forEach(input => {
      if (input) {
        input.classList.remove('is-invalid');
        const feedback = input.parentNode.querySelector('.invalid-feedback');
        if (feedback) {
          feedback.remove();
        }
      }
    });
    
    // Clear slot errors
    const slotError = document.querySelector('.slot-error');
    if (slotError) {
      slotError.remove();
    }
  }
  
  // Real-time validation clearing
  vehicleInput.addEventListener('input', function() {
    if (this.value.trim()) {
      this.classList.remove('is-invalid');
      const feedback = this.parentNode.querySelector('.invalid-feedback');
      if (feedback) {
        feedback.remove();
      }
    }
  });
  
  startTimeInput.addEventListener('change', function() {
    if (this.value) {
      this.classList.remove('is-invalid');
      const feedback = this.parentNode.querySelector('.invalid-feedback');
      if (feedback) {
        feedback.remove();
      }
    }
  });
  
  endTimeInput.addEventListener('change', function() {
    this.classList.remove('is-invalid');
    const feedback = this.parentNode.querySelector('.invalid-feedback');
    if (feedback) {
      feedback.remove();
    }
  });
  
  // Clear slot error on selection
  document.addEventListener('change', function(e) {
    if (e.target.name === 'booking[parking_slot_id]') {
      const slotError = document.querySelector('.slot-error');
      if (slotError) {
        slotError.remove();
      }
    }
  });
});