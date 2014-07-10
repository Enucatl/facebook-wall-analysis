'use strict'

###*
 # @ngdoc service
 # @name dondiApp.scatterTime
 # @description
 # # scatterTime
 # Factory in the dondiApp.
###
angular.module('dondiApp')
    .factory 'scatterTime', ->
        {
            scatterTime: ->
                margin = {top: 20, right: 20, bottom: 150, left: 70}
                width = 900
                height = 600
                radius = 3
                legend_square_size = 18
                x_scale = d3.time.scale()
                y_scale = d3.scale.ordinal()
                color_scale = d3.scale.category20()
                x_axis = d3.svg.axis()
                    .scale x_scale
                    .orient "bottom"
                y_axis = d3.svg.axis()
                    .scale y_scale
                    .orient "left"
                x_title = undefined
                y_title = undefined

                chart = (selection) ->
                    selection.each (data) ->
                            
                        #update scales
                        x_scale
                            .domain d3.extent data, (d) -> d.time
                            .rangeRound [0, width - margin.left - margin.right]
                        y_scale
                            .domain d3.range 1, 1 + d3.max data, (d) -> d.posts.length
                            .rangePoints [height - margin.top - margin.bottom, 0]


                        #select the svg if it exists
                        svg = d3.select this
                            .selectAll "svg"
                            .data [data]

                        #otherwise create the skeletal chart
                        g_enter = svg.enter()
                            .append "svg"
                            .append "g"

                        g_enter.append "g"
                            .classed "x axis", true
                            .append "text"
                            .classed "label", true
                            .attr "x", width - margin.right - margin.left
                            .attr "y", margin.bottom - 6
                            .style "text-anchor", "end"
                            .text x_title

                        g_enter.append "g"
                            .classed "y axis", true
                            .append "text"
                            .classed "label", true
                            .attr "y", -margin.left
                            .attr "transform", "rotate(-90)"
                            .attr "dy", "2em"
                            .style "text-anchor", "end"
                            .text y_title

                        g_enter.append "g"
                            .classed "intervals", true

                        g_enter.append "g"
                            .classed "legends", true

                        #update the dimensions
                        svg
                            .attr "width", width
                            .attr "height", height

                        #update position
                        g = svg.select "g"
                            .attr "transform", "translate(#{margin.left}, #{margin.top})"

                        #update circles
                        intervals = g.select ".intervals"
                            .selectAll "g"
                            .data (d) -> d

                        intervals
                            .enter()
                            .append "g"
                            .classed "interval", true
                            .attr "transform", (d) -> "translate(#{x_scale d.time}, 0)"

                        intervals
                            .exit()
                            .remove()

                        links = intervals
                            .selectAll "a"
                            .data (d) -> d.posts

                        links
                            .enter()
                            .append "a"
                            .attr "xlink:href", (d) -> "http://www.facebook.com/#{d.id.split("_")[0]}/posts/#{d.id.split("_")[1]}"
                            .append "circle"

                        circles = links.select "circle"
                            .attr "r", radius
                            .attr "cy", (d, i) -> y_scale i + 1
                            .attr "fill", (d) -> color_scale d.type
                            .append "title"
                            .text (d) -> 
                                elements = [d.author, d.message, d.description].filter (e) -> e?
                                elements.join ", "

                        links
                            .exit()
                            .remove()

                        #update legend
                        legends = g.select "g.legends"
                            .selectAll "g.legend"
                            .data color_scale.domain()

                        legends
                            .enter()
                            .append "g"
                            .classed "legend", true
                            .attr "transform", (d, i) -> "translate(0, #{(legend_square_size + 2) * i})"

                        legends
                            .each (d) ->
                                rects = d3.select this
                                    .selectAll "rect"
                                    .data [d]
                                rects.enter()
                                    .append "rect"
                                    .attr "x", width - margin.right - margin.left - legend_square_size
                                    .attr "width", legend_square_size
                                    .attr "height", legend_square_size
                                rects
                                    .style "fill", color_scale
                                texts = d3.select this
                                    .selectAll "text"
                                    .data [d]
                                texts.enter()
                                    .append "text"
                                    .attr "x", width - margin.right - margin.left - legend_square_size - 2
                                    .attr "y", legend_square_size / 2
                                    .attr "dy", "0.35em"
                                    .style "text-anchor", "end"
                                texts
                                    .text (d) -> d

                        legends
                            .exit()
                            .remove()

                        #update axes
                        g.select ".x.axis"
                            .attr "transform", "translate(0, #{y_scale.range()[0]})"
                            .call x_axis
                            .selectAll "text"
                                .style "text-anchor", "end" 
                                .attr "dx", "-.8em" 
                                .attr "dy", ".15em" 
                                .attr "transform", "rotate(-65)" 

                        y_axis
                            .tickValues y_scale.domain().filter (d, i) -> not (d % 10)
                        g.select ".y.axis"
                            .transition()
                            .call y_axis

                chart.width = (value) ->
                    if not arguments.length
                        return width
                    width = value
                    chart

                chart.height = (value) ->
                    if not arguments.length
                        return height
                    height = value
                    chart

                chart.margin = (value) ->
                    if not arguments.length
                        return margin
                    margin = value
                    chart

                chart.x_value = (value) ->
                    if not arguments.length
                        return x_value
                    x_value = value
                    chart

                chart.color_value = (value) ->
                    if not arguments.length
                        return color_value
                    color_value = value
                    chart

                chart.y_value = (value) ->
                    if not arguments.length
                        return y_value
                    y_value = value
                    chart

                chart.x_title = (value) ->
                    if not arguments.length
                        return x_title
                    x_title = value
                    chart

                chart.y_title = (value) ->
                    if not arguments.length
                        return y_title
                    y_title = value
                    chart

                chart.legend_square_size = (value) ->
                    if not arguments.length
                        return legend_square_size
                    legend_square_size = value
                    chart

                chart.radius = (value) ->
                    if not arguments.length
                        return radius
                    radius = value
                    chart

                chart.x_axis = (value) ->
                    if not arguments.length
                        return x_axis
                    x_axis = value
                    chart

                chart.y_axis = (value) ->
                    if not arguments.length
                        return y_axis
                    y_axis = value
                    chart

                chart.x_scale = (value) ->
                    if not arguments.length
                        return x_scale
                    x_scale = value
                    chart

                chart.y_scale = (value) ->
                    if not arguments.length
                        return y_scale
                    y_scale = value
                    chart

                chart
        }
