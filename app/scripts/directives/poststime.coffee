'use strict'

###*
 # @ngdoc directive
 # @name dondiApp.directive:postsTime
 # @description
 # # postsTime
###
angular.module 'dondiApp' 
    .directive 'postsTime', [
        "scatterTime"
        (scatterTime) ->
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
                    scatter = scatterTime.scatterTime()
                        .x_value (d) -> d.time
                        .color_value (d) -> d.type
                        .radius 3
                        .height height
                        .width width

                    interval = d3.time.week
                    date_range = d3.extent data, (d) -> d.time
                    intervals = interval.range(
                        interval.floor(date_range[0]),
                        interval.ceil(date_range[1])
                    )

                    grouped_data = intervals.map (d) ->
                        {
                            time: d
                            posts: data.filter (e) ->
                                interval.floor(e.time).getTime() == d.getTime()
                        }

                    d3.select element[0]
                        .data [grouped_data]
                        .call scatter
        ]
