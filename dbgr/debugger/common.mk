include $(top_srcdir)/common.mk

lispdir = @lispdir_dbgr@/debugger/$(notdir $(subdir))
lisp_files := $(wildcard *.el)
lisp_LISP = $(lisp_files)
EXTRA_DIST = $(lisp_files) 
MOSTLYCLEANFILES = *.elc
