'use strict'

###*
 # @ngdoc directive
 # @name dondiApp.directive:timeOfDay
 # @description
 # # timeOfDay
###
angular.module('dondiApp')
    .directive('timeOfDay', [
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
                    width = element.parent()[0].offsetWidth
                    factor = 0.618
                    height = factor * width
                    day_begins = new Date(2012, 0, 1, 6, 0, 0, 0)
                    day_ends = new Date(2012, 0, 2, 6, 0, 0, 0)
                    hours_since_day_begins = (day_begins - d3.time.day day_begins)
                    scatter = scatterTime.scatterTime()
                        .x_value (d) -> d.time
                        .y_value (d) ->
                            if d.time.getHours() < day_begins.getHours()
                                return d3.time.day.offset((d3.time.day(day_begins).getTime() + (d.time - d3.time.day d.time)), 1)
                            else
                                return d3.time.day(day_begins).getTime() + (d.time - d3.time.day d.time)
                        .color_value (d) ->
                            if d.author_id is "100000203184885" then "profile owner" else "guests"
                        .radius (d) -> 1 + d.n_comments
                        .width width
                        .height height

                    margin = scatter.margin()
                    scatter.x_scale()
                        .domain d3.extent data, (d) -> d.time
                        .rangeRound [0, width - margin.left - margin.right]
                    scatter.y_scale(
                        d3.time.scale()
                            .domain [day_begins, day_ends]
                            .range [height - margin.top - margin.bottom, 0]
                        )
                        .y_axis()
                            .tickFormat d3.time.format "%H:%M"

                    interval = d3.time.week
                    date_range = d3.extent data, (d) -> d.time
                    intervals = interval.range(
                        interval.floor(date_range[0]),
                        interval.ceil(date_range[1])
                    )

                    d3.select element[0]
                        .data [data]
                        .call scatter
    ]
)
