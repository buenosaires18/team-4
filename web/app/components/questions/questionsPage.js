angular.module('PescarApp')

.controller('QuestionsPageCtrl', function($scope, $filter, $state) {

  $scope.questions = [
      {
          text:"Alguien sabe cual es el profesor de diseño?",
          answers: [
              {
                  respuestaId: 1,
                  text: "Soy yo",
                  user:"Pepe"
              },
              {
                  respuestaId: 2,
                  text: "Se llama pablo",
                  user:"Juan"
              }
          ],
          respuestaElegida: 2
      }
      ]


});