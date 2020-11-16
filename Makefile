.PHONY: test install pep8 release clean

test: pep8
	py.test --doctest-modules codemod

install:
	python setup.py develop

pep8:
	# W503: Line break occurred before a binary operator
	# W504: Line break occurred after a binary operator
	#
	# W503 conflicts with W504, but since W504 is now the recommended style, we
	# intentionally ignore it.
	# https://www.python.org/dev/peps/pep-0008/#should-a-line-break-before-or-after-a-binary-operator
	@flake8 codemod --ignore=W503

release: test
	@python setup.py sdist upload

clean:
	@find ./ -name '*.pyc' -exec rm -f {} \;
	@find ./ -name 'Thumbs.db' -exec rm -f {} \;
	@find ./ -name '*~' -exec rm -f {} \;
