'use strict'

###*
 # @ngdoc directive
 # @name dondiApp.directive:postsTime
 # @description
 # # postsTime
###
angular.module 'dondiApp' 
    .directive 'postsTime', [
        "d3Service"
        "scatterTime"
        (d3Service, scatterTime) ->
            restrict: 'E'
            scope: {
                data: "=feedContent"
            }
            link: (scope, element, attrs) ->
                d3Service.d3().then (d3) ->
                    scope.data.success (json) ->
                        console.log d3.range 10
                        console.log json.length, "inside directive"
                        console.log scatterTime
                        scatterTime.scatterTime()
                            .x_value (d) -> d.created_time
        ]
