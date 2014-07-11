'use strict'

###*
 # @ngdoc service
 # @name dondiApp.d3donut
 # @description
 # # d3donut
 # Service in the dondiApp.
###
angular.module('dondiApp')
    .factory 'd3Donut', ->
        # Public API here
        {
            d3Donut: ->
                margin = {top: 20, right: 20, bottom: 50, left: 70}
                width = 900
                height = 600
                value = (d) -> d.number
                color_value = (d) -> d.data.name
                radius = Math.min(width, height) / 2
                color_scale = d3.scale.ordinal()
                    .range ["#a50026", "#d73027", "#f46d43", "#fdae61", "#fee090", "#ffffbf", "#e0f3f8", "#abd9e9", "#74add1", "#4575b4", "#313695"]

                chart = (selection) ->
                    selection.each (data) ->
                            
                        arc = d3.svg.arc()
                            .outerRadius 0.9 * radius
                            .innerRadius 0.7 * radius

                        #select the svg if it exists
                        svg = d3.select this
                            .selectAll "svg"
                            .data [data]

                        #otherwise create the skeletal chart
                        g_enter = svg.enter()
                            .append "svg"
                            .append "g"

                        g_enter.append "g"
                            .classed "donut", true

                        #update the dimensions
                        svg
                            .attr "width", width
                            .attr "height", height

                        #update position
                        g = svg.select "g"
                            .attr "transform", "translate(#{width / 2}, #{height / 2})"

                        #create donut layout
                        pie = d3.layout.pie()
                            .sort null
                            .value value

                        arc_groups = g.select "g.donut"
                            .selectAll ".arc"
                            .data pie data

                        arc_groups
                            .enter()
                            .append "g"
                            .classed "arc", true
                            .append "path"

                        arc_groups
                            .append "text"
                        arc_groups
                            .append "title"

                        arcs = arc_groups
                            .select "path"
                            .attr "d", arc
                            .style "fill", (d) ->
                                color_scale color_value d

                        arc_groups
                            .select "text"
                            .attr "transform", (d) -> "translate(#{arc.centroid d})"
                            .attr "dy", ".35em"
                            .style "text-anchor", "middle"
                            .text (d) -> color_value d

                        arc_groups
                            .select "title"
                            .text (d) -> "#{value d.data} posts"

                        arc_groups
                            .exit()
                            .transition()
                            .remove()

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

                chart.color_scale = (value) ->
                    if not arguments.length
                        return color_scale
                    color_scale = value
                    chart

                chart.margin = (value) ->
                    if not arguments.length
                        return margin
                    margin = value
                    chart

                chart.value = (v) ->
                    if not arguments.length
                        return value
                    value = v
                    chart

                chart
        }
