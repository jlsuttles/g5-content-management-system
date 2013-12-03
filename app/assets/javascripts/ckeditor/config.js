CKEDITOR.config.toolbarGroups = [
  { name: 'clipboard' },
	{ name: 'basicstyles' },
	{ name: 'paragraph', groups: [ 'list', 'align' ] },
	{ name: 'links' },
	{ name: 'styles' }
];
CKEDITOR.config.removeButtons = 'Anchor,Underline,Strike,Subscript,Superscript,Copy,Cut,Styles,Font,FontSize';
CKEDITOR.config.removeDialogTabs = 'link:advanced';
CKEDITOR.config.dialog_backgroundCoverColor = 'transparent'