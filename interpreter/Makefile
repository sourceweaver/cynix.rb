PROJECT_NAME = interpreter
ENTRY_FILE   = src/main.coffee
BUILD_DIR    = dist

WATCH_CMD     = "npx coffee --map --output $(BUILD_DIR) -c $(ENTRY_FILE) && node $(BUILD_DIR)/main.js"
WATCH_IGNORE  = -R 'node_modules' -R 'parcel_cache' -R 'dist'
WATCH_OPTIONS = --decoration='none'

.PHONY: watch
watch: clean
	../bin/reflex $(WATCH_IGNORE) -r '\.coffee$/' $(WATCH_OPTIONS) -s -- sh -c $(WATCH_CMD)

.DEFAULT_GOAL: build
build: clean
	npm run build

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR) || true
	rm -rf .parcel_cache

