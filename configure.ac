# Initialization

AC_INIT([caja-dropbox], [1.26.0], [https://mate-desktop.org])

AM_INIT_AUTOMAKE([1.9 tar-ustar dist-xz foreign no-dist-gzip])
m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

AC_CONFIG_MACRO_DIR([m4])
AC_PREFIX_DEFAULT(/usr)

AC_CONFIG_HEADERS(config.h)

MATE_COMPILE_WARNINGS

# gettext
GETTEXT_PACKAGE=AC_PACKAGE_NAME
AC_SUBST(GETTEXT_PACKAGE)
AC_DEFINE_UNQUOTED(GETTEXT_PACKAGE, "$GETTEXT_PACKAGE", [gettext package])

AM_GNU_GETTEXT([external])
AM_GNU_GETTEXT_VERSION([0.19.8])
AM_CONDITIONAL([USE_NLS], [test "x${USE_NLS}" = "xyes"])

# Dependency checks
CAJA_REQUIRED=1.17.1
GLIB_REQUIRED=2.50.0

# Used programs
AC_PROG_CC
AM_PROG_LIBTOOL

# Check for pkg-config
PKG_PROG_PKG_CONFIG

PKG_CHECK_MODULES(CAJA, libcaja-extension >= $CAJA_REQUIRED)
PKG_CHECK_MODULES(GLIB, glib-2.0 >= $GLIB_REQUIRED)

AC_PATH_PROG([PYTHON3], [python3])

AC_PATH_PROG([RST2MAN], [rst2man], [python3 rst2man.py])
AC_SUBST(RST2MAN)

# define module checking macro
AC_DEFUN([PYTHON3_CHECK_MODULE], [
AC_MSG_CHECKING([for $1 on python3])

cat <<EOF | python3
try:
 import $2
except:
 exit(1)
else:
 exit(0)
EOF

if test $? -ne 0; then
   AC_MSG_RESULT([no])
   AC_MSG_ERROR([couldn't find $1])
else
   AC_MSG_RESULT([yes])
fi
])

PYTHON3_CHECK_MODULE(docutils, docutils)
PYTHON3_CHECK_MODULE(gi, gi)

# Make dependency CFLAGS and LIBS available
AC_SUBST(CAJA_CFLAGS)
AC_SUBST(CAJA_LIBS)
AC_SUBST(GLIB_CFLAGS)
AC_SUBST(GLIB_LIBS)

# lol stolen from the automake manual
AC_ARG_ENABLE([debug],
[  --enable-debug    Turn on debugging],
[case "${enableval}" in
yes) debug=true ;;
no)  debug=false ;;
*) AC_MSG_ERROR([bad value ${enableval} for --enable-debug]) ;;
esac],[debug=false])
AM_CONDITIONAL([DEBUG], [test x$debug = xtrue])

AC_ARG_WITH(caja-extension-dir,
              [AS_HELP_STRING([--with-caja-extension-dir],
                    [specify the caja extension directory])])

# Get caja extensions directory
AC_MSG_CHECKING([for caja extension directory])
if test -n "$with_caja_extension_dir"; then
    CAJA_EXTENSION_DIR=$with_caja_extension_dir
    custom_caja_extension_dir=true
else
    CAJA_EXTENSION_DIR_SYS=`$PKG_CONFIG --variable=extensiondir libcaja-extension`
    CAJA_EXTENSION_DIR=${CAJA_EXTENSION_DIR_SYS#`$PKG_CONFIG --variable=libdir libcaja-extension`}
    CAJA_EXTENSION_DIR=${CAJA_EXTENSION_DIR#/}
    custom_caja_extension_dir=false
fi

if test x$custom_caja_extension_dir = xtrue; then
    AC_MSG_RESULT([${CAJA_EXTENSION_DIR}])
else
    AC_MSG_RESULT([${CAJA_EXTENSION_DIR_SYS}])
fi
AM_CONDITIONAL([CUSTOM_CAJA_EXTENSION_DIR], [test x$custom_caja_extension_dir = xtrue])
AC_SUBST(CAJA_EXTENSION_DIR)

CAJA_VERSION=`$PKG_CONFIG --modversion libcaja-extension`
if test -n "$CAJA_VERSION"; then
    CAJA_VERSION_MAJOR=`echo -n $CAJA_VERSION | cut -d . -f 1`
    CAJA_VERSION_MINOR=`echo -n $CAJA_VERSION | cut -d . -f 2`
    CAJA_VERSION_MICRO=`echo -n $CAJA_VERSION | cut -d . -f 3`
fi

AC_DEFINE_UNQUOTED(CAJA_VERSION_MAJOR, [$CAJA_VERSION_MAJOR], [ caja version major])
AC_DEFINE_UNQUOTED(CAJA_VERSION_MINOR, [$CAJA_VERSION_MINOR], [ caja version minor])
AC_DEFINE_UNQUOTED(CAJA_VERSION_MICRO, [$CAJA_VERSION_MICRO], [ caja version micro])

EMBLEM_DIR='${datadir}/caja-dropbox/emblems'
AC_SUBST(EMBLEM_DIR)

AC_CONFIG_FILES([
	Makefile
	src/Makefile
	data/Makefile
	data/libcaja-dropbox.caja-extension.in
	data/icons/Makefile
	data/icons/hicolor/Makefile
	data/icons/hicolor/16x16/Makefile
	data/icons/hicolor/16x16/apps/Makefile
	data/icons/hicolor/22x22/Makefile
	data/icons/hicolor/22x22/apps/Makefile
	data/icons/hicolor/24x24/Makefile
	data/icons/hicolor/24x24/apps/Makefile
	data/icons/hicolor/32x32/Makefile
	data/icons/hicolor/32x32/apps/Makefile
	data/icons/hicolor/48x48/Makefile
	data/icons/hicolor/48x48/apps/Makefile
	data/icons/hicolor/64x64/Makefile
	data/icons/hicolor/64x64/apps/Makefile
	data/icons/hicolor/256x256/Makefile
	data/icons/hicolor/256x256/apps/Makefile
	data/emblems/Makefile
	po/Makefile.in
])

AC_OUTPUT

dnl ---------------------------------------------------------------------------
dnl - Show summary
dnl ---------------------------------------------------------------------------

echo "
       caja-dropbox $VERSION
       `echo caja-dropbox $VERSION | sed "s/./=/g"`

       prefix:                     ${prefix}
       compiler:                   ${CC}
       cflags:                     ${CFLAGS}
       warning flags:              ${WARN_CFLAGS}
       custom caja extension dir:  ${CAJA_EXTENSION_DIR}
       system caja extension dir:  ${CAJA_EXTENSION_DIR_SYS}
       Native Language support:    ${USE_NLS}
"
