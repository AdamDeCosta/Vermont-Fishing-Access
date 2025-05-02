setup:
	./scripts/setup.sh

dependencies:
	./scripts/install_dependencies.sh

lint:
	swiftlint --lenient

format:
	./scripts/format_source.sh