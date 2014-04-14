App.AssetsController = Ember.ArrayController.extend
  needs: 'website'
  website: Ember.computed.alias("controllers.website.content")
  actions:
    saveAsset: (uploadedUrl) ->
      website = this.get('website')
      asset = App.Asset.createRecord({website: website, url: uploadedUrl})
      asset.save().then ((asset) =>
        console.log("saved")
      ), (asset)=>
        console.log('failed')
        errorField = undefined
        for key of asset.get('errors')
          errorField = key
        console.log("the error field is: " + errorField)
        asset.deleteRecord()
        #d = new Date();
        #$("#myimg").attr("src", "/myimg.jpg?"+d.getTime());
    deleteAsset: (asset) ->
      console.log('handling deleteAsset')
      uploader = Ember.S3Uploader.create(url: '/api/v1/sign')
      uploader.delete(asset)
