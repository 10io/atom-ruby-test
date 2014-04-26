TestParams = require '../lib/test-params'

describe "TestParams", ->
  beforeEach ->
    project =
      getPath: ->
        "fooPath"
      relativize: (filePath) ->
        "fooDirectory/#{filePath}"
    atom.project = project
    @savedTestCommand = atom.config.get("ruby-test.testFileCommand")
    atom.config.set("ruby-test.testFileCommand", "fooCommand")
    editor =
      buffer:
        file:
          path:
            "fooFilePath"
    spyOn(atom.workspace, 'getActiveEditor').andReturn(editor)
    @params = new TestParams()

  describe "::cwd", ->
    it "is atom.project.getPath()", ->
      expect(@params.cwd()).toBe("fooPath")

  describe "::testFileCommand", ->
    it "is the atom config for 'ruby-test.testFileCommand'", ->
      expect(@params.testFileCommand()).toBe("fooCommand")

  describe "::activeFile", ->
    it "is the project-relative path for the current file path", ->
      expect(@params.activeFile()).toBe("fooDirectory/fooFilePath")

  afterEach ->
    delete atom.project
    atom.config.set("ruby-test.testFileCommand", @savedTestCommand)
