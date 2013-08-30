CKEDITOR.config.toolbarGroups = [
  { name: 'clipboard' },
	{ name: 'basicstyles' },
	{ name: 'paragraph', groups: [ 'list', 'align' ] },
	{ name: 'links' },
	{ name: 'styles' }
];
CKEDITOR.config.removeButtons = 'Anchor,Underline,Strike,Subscript,Superscript,Copy,Cut,Styles,Font,FontSize,Link,Unlink';
CKEDITOR.config.removeDialogTabs = 'link:advanced';
