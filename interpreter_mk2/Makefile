PROJECT_NAME = interpreter
ENTRY_FILE   = cynix.rb

WATCH_CMD      = "ruby --yjit cynix.rb"
WATCH_TEST_CMD = "bundle exec rspec --format documentation"
WATCH_IGNORE   = -R 'vendor' -R '.bundle'
WATCH_OPTIONS  = --decoration='none'

.PHONY: watch
watch:
	../bin/reflex $(WATCH_IGNORE) -r '\.rb$/' $(WATCH_OPTIONS) -s -- sh -c $(WATCH_CMD)

.PHONY: watch/tests
watch/tests:
	../bin/reflex $(WATCH_IGNORE) -r '\.rb$/' $(WATCH_OPTIONS) -s -- sh -c $(WATCH_TEST_CMD)

.PHONY: test
test:
	bundle exec rspec --format documentation

.PHONY: ci-install-deps
ci-install-deps:
	bundle config path 'vendor/bundle' --local
	bundle install
