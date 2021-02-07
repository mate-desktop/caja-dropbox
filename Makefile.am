if USE_NLS
PO_SUBDIR = po
endif

SUBDIRS = $(PO_SUBDIR) data src

ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}

bin_SCRIPTS = caja-dropbox

CLEANFILES = \
	$(bin_SCRIPTS) \
	caja-dropbox.1 \
	caja-dropbox.txt

EXTRA_DIST = \
	autogen.sh \
	caja-dropbox.in \
	caja-dropbox.txt.in \
	docgen.py \
	rst2man.py \
	serializeimages.py

man_MANS = caja-dropbox.1

caja-dropbox: $(top_srcdir)/caja-dropbox.in $(top_srcdir)/serializeimages.py
	python3 $(top_srcdir)/serializeimages.py $(PACKAGE_VERSION) $(datadir)/applications $(GETTEXT_PACKAGE) $(datadir)/locale < $(top_srcdir)/caja-dropbox.in > caja-dropbox
	chmod +x caja-dropbox

caja-dropbox.1: $(top_srcdir)/caja-dropbox.txt.in caja-dropbox $(top_srcdir)/docgen.py
	python3 $(top_srcdir)/docgen.py $(PACKAGE_VERSION) $(top_srcdir)/caja-dropbox.txt.in caja-dropbox.txt
	$(RST2MAN) caja-dropbox.txt > caja-dropbox.1

DISTCHECK_CONFIGURE_FLAGS = \
    --enable-compile-warnings=no \
    CFLAGS='-Wno-deprecated-declarations'

# Build ChangeLog from GIT  history
ChangeLog:
	$(AM_V_GEN) if test -d $(top_srcdir)/.git; then \
		GIT_DIR="$(top_srcdir)/.git" git log --stat > $@; \
	fi

dist: ChangeLog

.PHONY: ChangeLog
