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
                scope.data.success (json) ->
                    factor = 0.618
                    width = element.parent()[0].offsetWidth
                    console.log width
                    height = factor * width
                    scatter = scatterTime.scatterTime()
                        .x_value (d) -> d.time
                        .color_value (d) -> d.type
                        .radius 3
                        .height height
                        .width width

                    digested_data = json.map (d) ->
                        {
                            author: d.from.name
                            time: new Date(d.created_time)
                            type: d.type
                            message: d.message
                            description: d.description
                            id: d.id
                        }

                    interval = d3.time.week
                    date_range = d3.extent digested_data, (d) -> d.time
                    intervals = interval.range(
                        interval.floor(date_range[0]),
                        interval.ceil(date_range[1])
                    )

                    grouped_data = intervals.map (d) ->
                        {
                            time: d
                            posts: digested_data.filter (e) ->
                                interval.floor(e.time).getTime() == d.getTime()
                        }

                    d3.select element[0]
                        .data [grouped_data]
                        .call scatter
        ]
