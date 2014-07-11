'use strict'

###*
 # @ngdoc function
 # @name dondiApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the dondiApp
###
angular.module('dondiApp')
    .controller 'MainCtrl', [
            "$scope"
            "$http"
            "$filter"
            ($scope, $http, $filter) ->
                $scope.posts = null
                $scope.filteredPosts = null
                $scope.shownPosts = null

                $scope.own_posts = false

                $scope.filterPosts = (only_own) ->
                    if only_own
                        $scope.shownPosts = $scope.filteredPosts
                    else
                        $scope.shownPosts = $scope.posts
                    $scope.groupedPosts = group_by_time($scope.shownPosts)

                group_by_time = (data) ->
                    interval = d3.time.week
                    date_range = d3.extent data, (d) -> d.time
                    intervals = interval.range(
                        interval.floor(date_range[0]),
                        interval.ceil(date_range[1])
                    )
                    intervals.map (d) ->
                        {
                            time: d
                            posts: data.filter (e) ->
                                interval.floor(e.time).getTime() == d.getTime()
                        }

                $http.get "data/100000203184885.json", {cache: true}
                    .success (json) ->
                        $scope.posts = json.map (d) ->
                            {
                                author: d.from.name
                                author_id: d.from.id
                                time: new Date(d.created_time)
                                type: if d.type is "swf" then "video" else d.type
                                message: d.message
                                description: d.description
                                id: d.id
                                n_comments: if d.comments? then d.comments.data.length else 0
                            }
                        $scope.filteredPosts = $filter("filter")($scope.posts, {author_id: 100000203184885})
                        $scope.shownPosts = $scope.posts
                        $scope.groupedPosts = group_by_time($scope.shownPosts)
        ]
