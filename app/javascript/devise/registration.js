export const updateLocation = function() {
  const submitButton = document.getElementById("submit_button");
  const locationMessage = document.getElementById("location_message");
  const latitudeField = document.getElementById("location_attributes_latitude");
  const longitudeField = document.getElementById("location_attributes_longitude");

  if (!latitudeField || !longitudeField) return;

  const enableSubmit = () => {
    submitButton.disabled = false;
    locationMessage.style.display = "none";
  }

  if (latitudeField.value && longitudeField.value) {
    enableSubmit();
  }
  else {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        latitudeField.value = position.coords.latitude;
        longitudeField.value = position.coords.longitude;

        enableSubmit();
      });
    }
  }
}

export const updateSitterFields = function() {
  const checkbox = document.getElementById('sitter_checkbox');
  const sitter_details = document.getElementById('sitter_fields');

  if (!checkbox || !sitter_details) return;

  if(checkbox.checked){
    sitter_details.style['display'] = 'block';
  } else {
    sitter_details.style['display'] = 'none';
  }
}

export const addUpdateSitterFieldsCallbackToButton = function() {
  const checkbox = document.getElementById('sitter_checkbox');

  if (!checkbox) return;

  checkbox.onchange = updateSitterFields;
}