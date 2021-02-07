applicationdir = $(datadir)/applications
application_in_files = caja-dropbox.desktop.in
application_DATA = $(application_in_files:.desktop.in=.desktop)
%.desktop: %.desktop.in Makefile
if USE_NLS
	$(AM_V_GEN) GETTEXTDATADIR=$(top_srcdir) $(MSGFMT) --desktop \
		--keyword= --keyword=Name --keyword=GenericName --keyword=Comment --keyword=Keywords \
		--template $< -d $(top_srcdir)/po -o $@
else
	$(AM_V_GEN) sed '/^# Translators/d' < $< > $@
endif

extensiondir = $(datadir)/caja/extensions
extension_in_in_files = libcaja-dropbox.caja-extension.in.in
extension_in_files = $(extension_in_in_files:.caja-extension.in.in=.caja-extension.in)
extension_DATA = $(extension_in_files:.caja-extension.in=.caja-extension)
$(extension_DATA): $(extension_in_files) Makefile
if USE_NLS
	$(AM_V_GEN) $(MSGFMT) --desktop --keyword= --keyword=Copyright --keyword=Name --keyword=Description --template $< -d $(top_srcdir)/po -o $@
else
	$(AM_V_GEN) cp -f $< $@
endif

EXTRA_DIST = \
	$(application_in_files) \
	$(extension_in_in_files)

CLEANFILES = \
	$(application_DATA) \
	$(extension_DATA)

DISTCLEANFILES = \
	$(extension_in_files)

SUBDIRS = icons emblems
