
(function(){
  'use strict';

  // Función para actualizar el valor en el input
  function updateValue(value) {
    const valueInput = document.getElementById('value');
    if (valueInput) {
      valueInput.value = value;
    }
  }

  // Configurar el evento para el botón de incremento
  document.addEventListener('DOMContentLoaded', function() {
    const incrementButton = document.getElementById('increment');
    if (incrementButton) {
      incrementButton.addEventListener('click', function() {
        // Verificar si el estado de Flutter está disponible
        if (window._appState && typeof window._appState._incrementCounter === 'function') {
          window._appState._incrementCounter();
        }
      });
    }
  });

  // Función que se llama desde Flutter cuando el estado está listo
  window._stateSet = function() {
    console.log('Estado de Flutter configurado');
    // Inicializar con el valor actual
    if (window._appState && window._appState._counter !== undefined) {
      updateValue(window._appState._counter);
    }
    
    // Configurar un observador para actualizar el valor cuando cambie
    if (window._appState) {
      // Esta es una implementación simplificada, en un caso real
      // necesitarías usar un mecanismo de observación más robusto
      setInterval(function() {
        if (window._appState && window._appState._counter !== undefined) {
          updateValue(window._appState._counter);
        }
      }, 100);
    }
  };
}());