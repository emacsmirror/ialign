emacs ?= emacs
FILES := ialign.el
ELC := $(FILES:.el=.elc)

ARGS := --batch -Q

PACKAGE_INIT := -f package-initialize

INSTALL_DEPENDENCIES := ${PACKAGE_INIT} --eval '(progn                             \
	(unless (package-installed-p (quote package-lint))                         \
	  (push (quote ("melpa" . "https://melpa.org/packages/")) package-archives)\
	  (package-refresh-contents)                                               \
	  (package-install (quote package-lint))))'

deps:
	${emacs} -Q --batch ${INSTALL_DEPENDENCIES}

compile: $(ELC)

%.elc: %.el
	${emacs} ${ARGS} -L .                                                 \
		--eval '(setq byte-compile-error-on-warn t)'                  \
	 -f batch-byte-compile $<

# Run emacs -Q with packages installed and ialign loaded
sandbox: ${ELC}
	${emacs} -Q -L . -l ialign

%.elc: %.el
	${emacs} -Q --batch ${PACKAGE_INIT} -L .                                               \
	    --eval '(setq byte-compile-error-on-warn t)'                       \
	    -f batch-byte-compile $<

%.lint-checkdoc: %.el
	@lint=$$(mktemp);                                                     \
	${emacs} -Q --batch $<                                                \
		--eval '(checkdoc-file (buffer-file-name))' 2>&1 | tee $$lint \
        && test -z "$$(cat $$lint)"

%.lint-long-lines: %.el
	@sed '1{s/.*//}' $< | grep -n -E "^.{80,}" `# Catch long lines`       \
	    | sed  -r 's/^([0-9]+).*/'$<':\1: Too long/;q1';

%.lint-package: %.el
	@file=$$(mktemp); \
	${emacs} -Q --batch ${PACKAGE_INIT}                              \
	  -f 'package-lint-batch-and-exit' $< 2>$$file || true          \
	&& sed -i "/^Entering directory/d" $$file                        \
	&& cat $$file \
	&& test -z "$$(cat $$file)"

%.lint: %.el %.lint-checkdoc %.lint-long-lines %.lint-package
	@true

lint: $(patsubst %.el,%.lint,$(filter-out %-test.el,$(FILES)))

update-copyright-years:
	year=`date +%Y`;                                                      \
	sed -i *.el *.org -r                                                  \
	  -e 's/Copyright \(C\) ([0-9]+)(-[0-9]+)?/Copyright (C) \1-'$$year'/'

clean:
	rm -f *.elc
