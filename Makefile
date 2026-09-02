.DEFAULT_GOAL := help
.PHONY: help format lint test server clean

SITE_DIR ?= docs
PORT ?= 8000
PYTHON ?= python3
PRETTIER ?= npx --yes prettier@3.3.3
RUFF ?= uvx ruff
REQUIRED_META ?= description viewport

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-8s\033[0m %s\n", $$1, $$2}'

format: ## Format homepage HTML (prettier) and Python helpers (ruff)
	$(PRETTIER) --write "$(SITE_DIR)/index.html"
	$(RUFF) format scripts tests

lint: format ## Static checks: ruff + local asset/anchor/meta validation of the built site
	$(RUFF) check scripts tests
	$(PYTHON) scripts/check_site.py $(SITE_DIR) --require-meta $(REQUIRED_META)

test: ## Run unit tests for the site checker
	$(PYTHON) -m unittest discover -s tests -v

server: ## Serve the site locally
	$(PYTHON) -m http.server $(PORT) --directory $(SITE_DIR)

clean: ## Remove Python caches
	find . -name "__pycache__" -type d -prune -exec rm -rf {} +
