# Check if the file exists
if [ -f config/keys.xcconfig ]; then
  echo "Error: config/keys.xcconfig already exists. Please delete before running."
  exit 1
fi

# Create the file and add the MAPBOX_TOKEN
touch config/keys.xcconfig
echo "MAPBOX_TOKEN = $1" >> config/keys.xcconfig