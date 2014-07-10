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
                scope.data.success (json) ->
                    factor = 0.618
                    width = element.parent()[0].offsetWidth
                    height = factor * width
                    base_date = new Date(2012, 0, 1, 0, 0, 0, 0)
                    difference_data = json[1...].map (d, i) ->
                        {
                            time: new Date(2012, 0, 1, 0, 0, 0, (new Date(json[i].created_time) - new Date(d.created_time)))
                        }

                    histogram = d3Histogram.d3Histogram()
                        .width width
                        .height height
                        .value (d) -> d.time
                        .n_bins 30
                        .x_title "interval between posts (hours)"
                        .y_title "posts / 1 hour"
                        .x_scale(d3.time.scale()
                            .domain [base_date, d3.time.day.offset(base_date, 1)])
                    histogram
                        .x_axis().scale histogram.x_scale()
                        .tickFormat d3.time.format "%H"
                    d3.select element[0]
                        .data [difference_data.filter (d) ->
                            d.time < new Date(2012, 0, 2, 0, 0, 0, 0)]
                        .call histogram
                        
    ]
)
