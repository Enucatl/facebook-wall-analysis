'use strict'

describe 'Service: scatterTime', ->

  # load the service's module
  beforeEach module 'dondiApp'

  # instantiate service
  scatterTime = {}
  beforeEach inject (_scatterTime_) ->
    scatterTime = _scatterTime_

  it 'should do something', ->
    expect(!!scatterTime).toBe true
