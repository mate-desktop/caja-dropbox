ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAG}

bin_SCRIPTS = caja-dropbox
CLEANFILES = $(bin_SCRIPTS) caja-dropbox.1 caja-dropbox.txt
EXTRA_DIST = caja-dropbox.in serializeimages.py caja-dropbox.txt.in docgen.py rst2man.py
man_MANS = caja-dropbox.1

caja-dropbox: caja-dropbox.in serializeimages.py
	python serializeimages.py $(PACKAGE_VERSION) $(datadir)/applications < caja-dropbox.in > caja-dropbox
	chmod +x caja-dropbox

caja-dropbox.1: caja-dropbox.txt.in caja-dropbox docgen.py
	python docgen.py $(PACKAGE_VERSION) < caja-dropbox.txt.in > caja-dropbox.txt
	$(RST2MAN) caja-dropbox.txt > caja-dropbox.1

SUBDIRS = data src
