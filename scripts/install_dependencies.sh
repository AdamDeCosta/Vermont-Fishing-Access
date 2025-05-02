if !command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required for project setup"
  exit 1
fi

brew install xcodegen
brew install swiftlint
brew install swiftformat

