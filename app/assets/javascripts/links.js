document.addEventListener('DOMContentLoaded', function() {
   var typeSelected = document.getElementById('link_type_field');
   var dateField = document.getElementById('link_expiration_date_field');
   var dateSelected = dateField.querySelectorAll('select');
   var passwordField = document.getElementById('password_field');

   dateSelected.forEach(function (select) {
       select.value = null;
   });

   dateField.style.display = 'none';
   passwordField.style.display = 'none';

   typeSelected.addEventListener('change', function() {
       if (typeSelected.value === 'TemporalLink') {
           dateField.style.display = 'block';
       } else {
           dateField.style.display = 'none';
       }
       if (typeSelected.value === 'PrivateLink') {
           passwordField.style.display = 'block';
       } else {
           passwordField.style.display = 'none';
       }
   });
});
