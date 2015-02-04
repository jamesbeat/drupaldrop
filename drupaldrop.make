core = 7.x
api = 2

;Common modules.
projects[ctools]
projects[ds]
projects[entity]
projects[jquery_update]
projects[libraries]
projects[rules]
projects[token]
projects[variable]

;Content Modules
projects[content_access]
projects[blockify]
projects[exclude_node_title]
projects[field_group]
projects[image_style_quality]
projects[insert]
projects[insert_block]
projects[references]
projects[tablefield]
projects[ace_editor]

;Menu Modules
projects[menu_attributes]
projects[menu_position]
projects[menu_views]
projects[multiple_node_menu]

;Views
projects[views]
projects[views_bulk_operations]
projects[views_php]
projects[views_Slideshow]

;Registration
projects[registration]
projects[calendar]
projects[date]
projects[location]

;Email
projects[mailsystem]
projects[smtp]
projects[htmlmail]
projects[mimemail]

;Admin Modules
projects[admin_menu]
projects[backup_migrate]
projects[module_filter]
projects[google_analytics]

; Development modules.
projects[devel]

; Multilingual modules.
projects[fallback_language_negotation]
projects[variable]
projects[i18n]
projects[i18nviews]
projects[l10n_update]
projects[language_switcher]


; THEMES

projects[ember]
projects[basic]

;Libraries
libraries[ace][download][type] = file
libraries[ace][download][url] = https://github.com/ajaxorg/ace-builds/archive/master.zip

libraries[jquery.cycle][download][type] = file
libraries[jquery.cycle][download][url] = http://malsup.github.io/jquery.cycle.all.js

libraries[modernizr][download][type] = file
libraries[modernizr][download][url] = http://modernizr.com/downloads/modernizr-latest.js

libraries[emogrifier][download][type] = file
libraries[emogrifier][download][url] = https://github.com/jjriv/emogrifier/archive/master.zip


; Load some translations.
translations[] = de