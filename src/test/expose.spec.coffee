describe 'Expose', ->

  describe 'meta', ->

    it 'should exist', ->
      expect(expose).toBeDefined()

    it 'should have `noConflict()` method', ->
      expect(expose.noConflict).toBeDefined()
