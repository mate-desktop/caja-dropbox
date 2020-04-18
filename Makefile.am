ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}

bin_SCRIPTS = caja-dropbox
CLEANFILES = $(bin_SCRIPTS) caja-dropbox.1 caja-dropbox.txt
EXTRA_DIST = caja-dropbox.in serializeimages.py caja-dropbox.txt.in docgen.py rst2man.py autogen.sh
man_MANS = caja-dropbox.1

caja-dropbox: $(top_srcdir)/caja-dropbox.in $(top_srcdir)/serializeimages.py
	python3 $(top_srcdir)/serializeimages.py $(PACKAGE_VERSION) $(datadir)/applications < $(top_srcdir)/caja-dropbox.in > caja-dropbox
	chmod +x caja-dropbox

caja-dropbox.1: $(top_srcdir)/caja-dropbox.txt.in caja-dropbox $(top_srcdir)/docgen.py
	python3 $(top_srcdir)/docgen.py $(PACKAGE_VERSION) $(top_srcdir)/caja-dropbox.txt.in caja-dropbox.txt
	$(RST2MAN) caja-dropbox.txt > caja-dropbox.1

SUBDIRS = data src

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

