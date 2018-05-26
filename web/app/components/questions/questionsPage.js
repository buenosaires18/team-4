angular.module('PescarApp')

.controller('QuestionsPageCtrl', function($scope, questionsManager) {

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

    $scope.getQuestionsData = function(){
        questionsManager.getQuestions(function(response){
            response.data.forEach(function(question, index){
                var answer = [];
                $scope.getAnswersByQuestionId(question.id, function(response){
                    $scope.questions[index].answers = response.data;
                    $scope.filteredQuestions = $scope.getFilteredQuestions();
                }, function(){
                    $scope.questions[index].answers = $scope.answers[question.id];
                    $scope.filteredQuestions = $scope.getFilteredQuestions();
                });
            });
            $scope.questions = response.data;
            $scope.filteredQuestions = $scope.getFilteredQuestions();
        }, function(error){
            console.warn("request error");
        })
    };

    $scope.getAnswersByQuestionId = function(questionId, onSuccess, onError){
        questionsManager.getAnswersByQuestionId(questionId, onSuccess, onError)
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
    $scope.answers = {
        1: [
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
        2: [
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
        3: [
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
        ]
    };


    $scope.filteredQuestions = $scope.getFilteredQuestions();


});