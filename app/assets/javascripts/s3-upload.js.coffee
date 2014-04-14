App.S3UploadComponent = Ember.FileField.extend(
  url: ""
  
  # S3 will return XML with url
  # => http://yourbucket.s3.amazonaws.com/file.png
  # Uploader will send a sign request then upload to S3
  filesDidChange: (->
    uploadUrl = @get("url")
    files = @get("assets")
    debugger
    uploader = Ember.S3Uploader.create(url: uploadUrl)
    uploader.on "didUpload", (response) ->
      uploadedUrl = $(response).find("Location")[0].textContent
      uploadedUrl = unescape(uploadedUrl)
      asset = App.Asset.createRecord({ website: @website, url: uploadedUrl })
      self.get('controller.target').get('store').commit()
      debugger
      return

    uploader.upload files[0]  unless Ember.isEmpty(files)
    return
  ).observes("assets")
)

