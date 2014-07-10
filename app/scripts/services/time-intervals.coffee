'use strict'

###*
 # @ngdoc service
 # @name dondiApp.timeIntervals
 # @description
 # # timeIntervals
 # Factory in the dondiApp.
###
angular.module('dondiApp')
  .factory 'timeIntervals', ->
    # Service logic
    # ...

    meaningOfLife = 42

    # Public API here
    {
      someMethod: ->
        meaningOfLife
    }
