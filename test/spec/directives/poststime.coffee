'use strict'

describe 'Directive: postsTime', ->

  # load the directive's module
  beforeEach module 'dondiApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<posts-time></posts-time>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the postsTime directive'
