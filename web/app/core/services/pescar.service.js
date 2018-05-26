angular.module('PescarApp')

.service("questionsManager", function($http){

    this.getQuestions = function(onSuccess, onError) {

        $http.get('http://localhost:8000/questions/',{}).then(function successCallback(response) {
            onSuccess(response);

        }, function errorCallback(response) {
            onError(response);
        });
    };

    this.getAnswersByQuestionId = function(questionId, onSuccess, onErro){
        $http.get('http://localhost:8000/answers/'+questionId,{}).then(function successCallback(response) {
            onSuccess(response);
        }, function errorCallback(response) {
            onError(response);
        });
    }

})