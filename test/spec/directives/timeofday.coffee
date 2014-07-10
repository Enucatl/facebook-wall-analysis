'use strict'

describe 'Directive: timeOfDay', ->

  # load the directive's module
  beforeEach module 'dondiApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<time-of-day></time-of-day>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the timeOfDay directive'
