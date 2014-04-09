App.UploadFile = Ember.TextField.extend({
    tagName: 'input',
    attributeBindings: ['name'],
    type: 'file',
    change: function (e) {
        var reader, that;
        that = this;
        reader = new FileReader();
        reader.onload = function (e) {
            var fileToUpload = e.target.result;

            console.log(e.target.result); // this spams the console with the image content
            console.log(that.get('controller')); // output: Class {imageBinding: Binding,

            that.get('controller').set(that.get('name'), fileToUpload);
        };
        return reader.readAsText(e.target.files[0]);
    }
});

