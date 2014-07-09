'use strict'

###*
 # @ngdoc function
 # @name dondiApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the dondiApp
###
angular.module('dondiApp')
  .controller 'MainCtrl', ($scope, $http) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]

    $scope.data = $http.get "data/content.json", {cache: true}
        .success (data) ->
            console.log data
        .error (data, status, header, config) ->
            console.warn data, status, header, config
