'use strict'

describe 'Service: timeIntervals', ->

  # load the service's module
  beforeEach module 'dondiApp'

  # instantiate service
  timeIntervals = {}
  beforeEach inject (_timeIntervals_) ->
    timeIntervals = _timeIntervals_

  it 'should do something', ->
    expect(!!timeIntervals).toBe true
