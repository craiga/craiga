_sass/rouge.scss:
	bundle exec ./bin/rougify style base16.solarized > _sass/rouge.scss

drafts:  ## Build and serve the web site with blog post drafts.
	bundle exec jekyll serve --livereload --drafts

cv.pdf: cv.markdown;  ## Create CV PDF.
	bundle exec jekyll serve --port 8765 --quiet --detach
	pipenv run weasyprint http\://localhost\:8765/cv cv.pdf
	pkill -f jekyll

images: ## Create resized and compressed images.
	./images.sh

spellcheck: ## Check spelling.
	./spellcheck.sh

help: ## Display this help screen.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
