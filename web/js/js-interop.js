
(function(){
  'use strict';
  // Función que se llama desde Flutter cuando el estado está listo
  window._stateSet = function() {
   let appState = window._appState;
   
   let valueField = document.getElementById('value');
   let updateState  = function () {
    valueField.value = appState.count;
   };

   appState.addHandler(updateState);
   updateState();

   let incrementButton = document.getElementById('increment');
   incrementButton.addEventListener('click', function() {
    appState.increment();
   });
  };
}());