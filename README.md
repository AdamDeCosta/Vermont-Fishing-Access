# Vermont Fishing Access

## Table of Contents
- [Description](#description)
  - [Future Plans](#future-plans)
    - [Save Favorite Access Points](#save-favorite-access-points)
    - [Save Custom Pins](#save-custom-pins)
    - [Record your catches](#record-your-catches)
    - [Remind the user to upload their catches](#remind-the-user-to-upload-their-catches)
- [Development Setup](#development-setup)
  - [Install Dependencies](#install-dependencies)
    - [Tooling](#tooling)
  - [Project Setup](#project-setup)

## Description
Vermont Fishing Access is an iOS app dedicated to providing information on public fishing access points in Vermont. You can easily filter access points by species and see public Fish & Wildlife lands overlayed on the map. Easily open Apple Maps by opening an access point and tapping the map icon.

This app was created as a way to learn how to use [Mapbox](https://www.mapbox.com). Read more about my learnings here: [Learnings](Learnings.md)

### Future Plans

**Save Favorite Access Points** and allow the user to find them in a list and quickly opening them on the map.

**Save Custom Pins** by long tapping on the map and create a custom map pin. Add your own species information, notes, and keep your fishing hole private.

**Record your catches** by attaching or taking a photo. Associate your catch with a public or custom access point.

**Remind the user to upload their catches**. Utilize Mapbox's new Geofencing API to remind users to document their catches when they leave the area.

## Development Setup
Clone this repository

### Install Dependencies
This project uses [Xcodegen](https://github.com/yonaskolb/XcodeGen) to manage .xcodeproj files

1. Install [Xcode 16.2](https://developer.apple.com/download/all/?q=xcode%2016.2)
1. Install [Homebrew](https://brew.sh)
1. Run `make dependencies`

### Project Setup
1. Follow the [Mapbox instructions](https://docs.mapbox.com/ios/maps/guides/install/) on creating an account & generating a token.
1. Add your mapbox token to the project by running `./scripts/create_secrets.sh <token>`
    > This project loads your mapbox token into the info.plist file by reading `MAPBOX_TOKEN` from `config/keys.xcconfig`. \
      This script will take the first parameter and create the appropriate xcconfig file.
1. Run `make` or `make setup`
    > You will need to run this every time you change branches and there are new source files. \
      Read more about [Xcodegen](https://github.com/yonaskolb/XcodeGen)

