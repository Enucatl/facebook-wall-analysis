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

        $http.get "data/100000203184885.json", {cache: true}
            .success (json) ->
                $scope.posts = json.map (d) ->
                    {
                        author: d.from.name
                        time: new Date(d.created_time)
                        type: d.type
                        message: d.message
                        description: d.description
                        id: d.id
                        n_comments: if d.comments? then d.comments.data.length else 0
                    }
