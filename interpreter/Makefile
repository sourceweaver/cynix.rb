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

.PHONY: lint
lint:
	bundle exec rubocop

.PHONY: format
format:
	bundle exec rubocop --fix-layout

.PHONY: ci-install-deps
ci-install-deps:
	bundle config path 'vendor/bundle' --local
	bundle install


PARSER_GEN_DIR    = parser/parser_generator
PARSER_GEN_CMD 	  = npx syntax-cli
PARSER_GEN_TARGET = parser.g

GRAMMAR_FILE   = ../../cynix.bnf
CLI_FLAGS      =  --grammar $(GRAMMAR_FILE) --mode LALR1 --output $(PARSER_GEN_TARGET)

.PHONY: parser/generate
parser/generate:
	cd $(PARSER_GEN_DIR) && $(PARSER_GEN_CMD) $(CLI_FLAGS)


PARSER_DIR  = parser
PARSER_FILE = parser.coffee
SAMPLE_FILE = ../data/source.cyn
OUTPUT_FILE = ../data/out.json
.PHONY: parser/parse
parser/parse:
	cd $(PARSER_DIR) && npx coffee $(PARSER_FILE) $(SAMPLE_FILE) $(OUTPUT_FILE)
