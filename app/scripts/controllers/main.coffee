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
        $scope.data_promise = $http.get "data/content.json", {cache: true}
