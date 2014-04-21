App.FileUploadComponent = Ember.FileField.extend(
  url: ""
  filesDidChange: (->
    uploadUrl = @get("url")
    files = @get("files")
    uploader = Ember.Uploader.create(url: uploadUrl)
    uploader.upload files[0]  unless Ember.isEmpty(files)
    return
  ).observes("files")
)
