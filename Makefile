.PHONY: setup
setup:
	@echo sets up the development environment
	python3 -m venv venv
	@echo activate venv with 'source venv/bin/activate'

.PHONY: requirements
requirements:
	pip install black isort click requests_file pytest pytest-asyncio pytest-cov
	pip install -e .

documentation:
	cd docs && make html
	cd docs/build/html && git add -A && git commit -m 'updates'
	cd docs/build/html && git push origin gh-pages

test:
	python -m pytest tests -v

test-reports:
	python -m pytest --doctest-modules --junitxml=junit/test-results.xml --cov=requests-html --cov-report=xml --cov-report=html tests -v