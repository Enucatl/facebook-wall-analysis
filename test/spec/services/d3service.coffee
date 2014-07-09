'use strict'

describe 'Service: d3Service', ->

  # load the service's module
  beforeEach module 'dondiApp'

  # instantiate service
  d3Service = {}
  beforeEach inject (_d3Service_) ->
    d3Service = _d3Service_

  it 'should do something', ->
    expect(!!d3Service).toBe true
