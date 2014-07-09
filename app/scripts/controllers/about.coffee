'use strict'

###*
 # @ngdoc function
 # @name dondiApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the dondiApp
###
angular.module('dondiApp')
  .controller 'AboutCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
