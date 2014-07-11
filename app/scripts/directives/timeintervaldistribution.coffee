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
                scope.$watch "data", (data) ->
                    if not data?
                        return
                    factor = 0.618
                    width = element.parent()[0].offsetWidth
                    height = factor * width
                    base_date = new Date(2012, 0, 1, 0, 0, 0, 0)
                    difference_data = data[1...].map (d, i) ->
                        {
                            time: new Date(2012, 0, 1, 0, 0, 0, (data[i].time - d.time))
                        }

                    histogram = d3Histogram.d3Histogram()
                        .width width
                        .height height
                        .value (d) -> d.time
                        .n_bins 30
                        .x_title "interval between posts (hours)"
                        .y_title "number of posts / 1 hour"
                        .x_scale(d3.time.scale()
                            .domain [base_date, d3.time.day.offset(base_date, 1)])
                    histogram
                        .x_axis().scale histogram.x_scale()
                        .tickFormat d3.time.format "%H"

                    margin = histogram.margin()
                    
                    d3.select element[0]
                        .data [difference_data.filter (d) ->
                            d.time < new Date(2012, 0, 2, 0, 0, 0, 0)]
                        .call histogram

                    overflow = difference_data.reduce((total, d) ->
                            if d.time > new Date(2012, 0, 2, 0, 0, 0, 0) then total + 1 else total
                        , 0)

                    overflow_text = d3.select element[0]
                        .select "svg"
                        .selectAll "text.overflow"
                        .data [overflow]

                    overflow_text
                        .enter()
                        .append "text"

                    overflow_text
                        .classed "overflow", true
                        .attr "x", width - margin.left - margin.right
                        .attr "y", margin.top
                        .attr "dy", "0.35em"
                        .style "text-anchor", "end"
                        .text (d) -> "+#{d} more than one day apart"

                    overflow_text
                        .exit()
                        .remove()
                        
    ]
)
