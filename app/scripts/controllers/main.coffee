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
        $scope.data_promise = $http.get "data/100000203184885.json", {cache: true}
