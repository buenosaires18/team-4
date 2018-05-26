angular.module('PescarApp')

.controller('QuestionsPageCtrl', function($scope, $filter, $state) {

    $scope.getFilteredQuestions = function(){
        return $scope.questions.filter(function(question){
            return !question.chosenAnswer
        })
    };

    $scope.setBestAnswer = function(questionId, answerId){
        $scope.questions.forEach(function(question, index){
            if(question.id === questionId) {
                $scope.questions[index].chosenAnswer = answerId;
            }

        });

        $scope.filteredQuestions = $scope.getFilteredQuestions();
        //Enviar data a Server

    };

    $scope.questions = [
        {
            text:"Alguien sabe cual es el profesor de diseño?",
            id:1,
            answers: [
                  {
                      id: 1,
                      text: "Soy yo",
                      user:"Pepe"
                  },
                  {
                      id: 2,
                      text: "Se llama pablo",
                      user:"Juan"
                  }
            ],
            user: "Manuel",
            chosenAnswer: null
        },
        {
            text:"Alguien sabe cual es el profesor de diseño?",
            id:2,
            answers: [
                  {
                      id: 1,
                      text: "Soy yo",
                      user:"Pepe"
                  },
                  {
                      id: 2,
                      text: "Se llama pablo",
                      user:"Juan"
                  }
            ],
            user: "Manuel",
            chosenAnswer: null
        },
        {
            text:"Alguien sabe cual es el profesor de diseño?",
                id:3,
                answers: [
                      {
                          id: 1,
                          text: "Soy yo",
                          user:"Pepe"
                      },
                      {
                          id: 2,
                          text: "Se llama pablo",
                          user:"Juan"
                      }
            ],
            user: "Manuel",
            chosenAnswer: null
        }
    ];


    $scope.filteredQuestions = $scope.getFilteredQuestions();

});