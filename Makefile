APP_NAME=.

.PHONY: setup
setup:
	uv sync --extra dev
	uv run playwright install

.PHONY: upgrade
upgrade:
	uv lock --upgrade
	uv sync --extra dev

.PHONY: lint
lint:
	uv run black $(APP_NAME)/.
	uv run black tests

JUNIT ?= junit/test-results.xml

.PHONY: test
test:
	uv run pytest --junitxml=$(JUNIT) tests -v

.PHONY: docs-lint
docs-lint:
	markdownlint docs/**/*.md

.PHONY: docs-serve
docs-serve:
	mkdocs serve

.PHONY: docs-build
docs-build:
	mkdocs build --strict --verbose --site-dir public
