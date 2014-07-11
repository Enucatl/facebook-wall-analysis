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
                    width = element.parent()[0].offsetWidth
                    scatter = scatterTime.scatterTime()
                        .x_value (d) -> d.time
                        .color_value (d) -> d.type
                        .radius 3
                        .width width

                    scatter
                        .color_scale()
                        .domain ["link", "status", "video", "photo"]

                    factor = 2
                    maximum_posts = d3.max data, (d) -> d.posts.length
                    height = factor * scatter.radius() * maximum_posts + scatter.margin().top + scatter.margin().bottom
                    scatter.height height
                    margin = scatter.margin()

                    scatter.x_scale()
                        .domain d3.extent data, (d) -> d.time
                        .rangeRound [0, width - margin.left - margin.right]
                    scatter.y_scale()
                        .domain d3.range 1, 1 + maximum_posts
                        .rangePoints [height - margin.top - margin.bottom, 0]
                    scatter.y_axis()
                            .tickValues scatter.y_scale().domain().filter (d, i) -> not (d % 10)

                    d3.select element[0]
                        .data [data]
                        .call scatter
        ]
