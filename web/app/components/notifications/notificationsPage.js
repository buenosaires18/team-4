angular.module('PescarApp')

.controller('NotificationsPageCtrl', function($scope, $filter, $state) {
    var emptyNotification = {
        title:"",
        text:"",
        target:[]
    };
    $scope.config = {};
    $scope.config.showNotificationForm = false;
    $scope.config.newNotification = emptyNotification;
    $scope.targets = [
        {
            description:"Todos",
            id:1
        },
        {
            description:"Diseño grafico",
            id:2
        },
        {
            description:"Textil",
            id:3
        },
        {
            description:"Contabilidad",
            id:4
        },
        {
            description:"Egresados",
            id:5
        },
        {
            description:"IT",
            id:6
        },
        {
            description:"Funcionales",
            id:7
        }
    ];

    $scope.notifications = [
        {
            title:"Oferta laboral IT",
            text:"JP Morgan ha abierto nuevas vacantes que podrían interesarte",
            id:1,
            target:[
                {
                    description:"IT",
                    id:6
                },
                {
                    description:"Funcionales",
                    id:7
                }
            ],
            date:"2018-05-24"
        },
        {
            title:"Felicitaciones!",
            text:"Has completado la capacitación, sigue adelante!",
            id:2,
            target:[
                {
                    description:"Todos",
                    id:1
                }
            ],
            date:"2018-05-23"
        },
        {
            title:"Nuevo curso - Diseño gráfico",
            text:"Ahora esta disponible un nuevo curso de diseño grafico, no te lo pierdas!",
            id:3,
            target:[
                {
                    description:"Diseño digital",
                    id:4
                },
                {
                    description:"Egresados",
                    id:5
                }],
            date:"2018-05-20"
        }
    ];

    $scope.sendNotification = function(){
        $scope.config.newNotification.id = $scope.notifications.length;
        $scope.config.newNotification.date = new Date().toISOString().substring(0, 10);
        $scope.notifications.unshift($scope.config.newNotification);
    };

    $scope.handleTargetChange = function(targetParam) {
        var alreadyExists = false;

        $scope.config.newNotification.target.forEach(function(target, index){
            if(targetParam.id === target.id){
                $scope.config.newNotification.target.splice(index, 1);
                alreadyExists = true;
            }

        });

        if(!alreadyExists) {
            $scope.config.newNotification.target.push(targetParam);
        }
        console.info($scope.config.newNotification.target)

    }

    $scope.isTargetInList = function(targetId){
        $scope.config.newNotification.target.forEach(function(target){
            if(target.id === targetId){
                return true;
            }
        });
        return false;
    }

});