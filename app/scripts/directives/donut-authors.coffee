'use strict'

###*
 # @ngdoc directive
 # @name dondiApp.directive:donutAuthors
 # @description
 # # donutAuthors
###
angular.module('dondiApp')
    .directive('donutAuthors', [
        "d3Donut"
        (d3Donut) -> {
            restrict: 'E'
            scope: {
                data: "=feedContent"
            }
            link: (scope, element, attrs) ->
                scope.$watch "data", (data) ->
                    if not data?
                        return
                    factor = 0.618
                    width = factor * element.parent()[0].offsetWidth
                    height = width
                    author_data = []
                    for datum in data
                        author = $.grep author_data, (author) -> author.name == datum.author
                        if author[0]?
                            author[0].number++
                        else
                            author_data.push {
                                name: datum.author
                                number: 1
                            }

                    donut = d3Donut.d3Donut()
                        .width width
                        .height height

                    author_data.sort (a, b) -> b.number - a.number
                    first_n = donut.color_scale().range().length
                    grouped_others = author_data[0..first_n - 2]
                    others = {
                        name: "Others (#{author_data[(first_n - 1)..].length} people)"                                         
                        number: author_data[(first_n - 1)..].reduce ((total, new_element) -> total + new_element.number), 0
                    }                    
                    if others.number
                        grouped_others.push others
                    
                    d3.select element[0]
                        .data [grouped_others]
                        .call donut

        }
    ]
)
