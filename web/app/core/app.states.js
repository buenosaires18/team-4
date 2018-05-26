angular.module('PescarApp')

.config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {
  $urlRouterProvider.when('', '/preguntas-de-alumnos');
  $urlRouterProvider.otherwise('/preguntas-de-alumnos');
  
  $stateProvider
    // .state('landingPage', {
    //   url: '/',
    //   templateUrl: './../components/landingPage/landingPage.html',
    //   controller: 'LandingPageCtrl',
    //   controllerAs: 'ctrl'
    // })
    .state('questionsPage', {
      url: '/preguntas-de-alumnos',
      templateUrl: './../components/questions/questionsPage.html',
      controller: 'QuestionsPageCtrl',
      controllerAs: 'ctrl'
    })
    .state('notificationsPage', {
      url: '/notificaciones',
      templateUrl: './../components/notifications/notificationsPage.html',
      controller: 'NotificationsPageCtrl',
      controllerAs: 'ctrl'
    })
    .state('coursesPage', {
      url: '/gestion/cursos',
      templateUrl: './../components/courses/coursesPage.html',
      controller: 'CoursesPageCtrl',
      controllerAs: 'ctrl'
    })

}])
