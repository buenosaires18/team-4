angular.module('PescarApp')

.controller('BaseCtrl', function($scope, $state) {
  $scope.goToState = function(state, params){
    var params = params || {};
    console.info("state");
    $state.go(state, params);
  }
});