'use strict'

###*
 # @ngdoc directive
 # @name dondiApp.directive:timeIntervalDistribution
 # @description
 # # timeIntervalDistribution
###
angular.module('dondiApp')
    .directive('timeIntervalDistribution', [
        "d3Histogram",
        (d3Histogram) ->
            restrict: 'E'
            scope: {
                data: "=feedContent"
            }
        link: (scope, element, attrs) ->
    ]
)
