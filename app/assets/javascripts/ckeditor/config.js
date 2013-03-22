CKEDITOR.config.toolbarGroups = [
  { name: 'clipboard',   groups: [ 'clipboard' ] },
	{ name: 'basicstyles', groups: [ 'basicstyles' ] },
	{ name: 'paragraph',   groups: [ 'list', 'align' ] },
	{ name: 'links' },
	{ name: 'styles', groups: [ 'styles' ], items: [ 'Paragraph Format' ] }
];
CKEDITOR.config.removeButtons = 'Anchor,Underline,Strike,Subscript,Superscript,Copy,Cut';
CKEDITOR.config.removeDialogTabs = 'link:advanced';
