angular.module('PescarApp')

.controller('CoursesPageCtrl', function($scope, $filter, $state) {
    $scope.selectedCourse=null;
    $scope.courses = [
        {
            id:0,
            title: "Desarrollo Web"
        },
        {
            id:1,
            title: "Desarrollo Mobile"
        },
        {
            id:2,
            title: "Fundamentos de html"
        },
        {
            id:3,
            title: "Ciberseguridad"
        },
        {
            id:4,
            title: "Injeccion SQL"
        }
    ];

    $scope.students = [
        {
            id: 0,
            name: "Marcos Mendez",

        },
        {
            id: 1,
            name: "Horacio Lopez",

        },
        {
            id: 2,
            name: "Maria Gomez",

        },
        {
            id: 3,
            name: "Erick Galeno",

        },
        {
            id: 4,
            name: "Marisa Cervantes",

        },
        {
            id: 5,
            name: "Carla Martinez",

        },
        {
            id: 6,
            name: "Marcos",

        }
    ];

    $scope.shuffleArray = function(array) {
        for (var i = array.length - 1; i > 0; i--) {
            var j = Math.floor(Math.random() * (i + 1));
            var temp = array[i];
            array[i] = array[j];
            array[j] = temp;
        }
    }

});