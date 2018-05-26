'use strict';

angular.module('PescarApp', [
  'ui.router',
])
.config(['$locationProvider', function($locationProvider) {
  $locationProvider.html5Mode({enabled:true})
  
}]);
