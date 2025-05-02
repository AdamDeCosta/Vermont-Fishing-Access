# Learnings

## Secrets Management using .xcconfig
- While keeping secrets out of the codebase is not a new concept for me, utilizing xcconfig to inject the secret into an `Info.plist` is. For this project, the token is stored securely in `config/keys.xcconfig` which is not checked into the repository.
  - The `create_secrets.sh` script dynamically generates the `keys.xcconfig` file.
  - The token is referenced in the `Info.plist` file using the `$(MAPBOX_TOKEN)` placeholder.
  - This setup ensures security and flexibility, as the token can be updated without modifying the source code. While this doesn't prevent someone from opening the app bundle and retrieving the token, it does prevent exposing the token in the codebase. For this use case, it means someone can easily clone the repository and enter their own Mapbox token to start developing.

## GeoJSON Data Integration
Before working on this project, I had not heard of GeoJSON before. From my research GeoJSON is a JSON-based format for encoding geographic data structures. It is able to represent geometry types such as: Point, LineString, Polygon, MultiPoint, MultiLineString, and MultiPolygon. These geometries are part of the `Feature` object. Features contain information about their geometry & properties. Properties are a collection of metadata about the feature. For this project, I reference the properties of an Access Point feature:
```json
{
  "type": "FeatureCollection",
  "name": "Fishing_Access_Areas",
  "features": [
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [ -72.1515, 44.8797 ]
      },
      "properties": {
        "id": 1,
        "AccessName": "Brownington Pond",
        "SmallmouthBass": "Yes",
        "NorthernPike": "No"
        ... // More fish types available
      }
    }
  ]
}
```

By adding this GeoJSON dataset to the project, I was able to add it as a `GeoJsonSource` in the map. This dynamically loads the data of the feature as their geometry comes into view.

**Future learnings**: Does a source dynamically load the information as it "comes into view" if there is not a layer referencing it? I could probably find this out by adding the `onSourceDataLoaded` ViewModifier to the Map and printing out the data when it is loaded and matches the source which has accompanying layer.

> [Read more about Geojson](https://geojson.org)

## Adding Map Layers w/ SwiftUI
Adding a` GeoJSONSource` (or any source) is just the first step in displaying data on the map. Depending on the geometry type of the feature, there are various layer types one can add. For the Access Points, this was added to the map using a `CircleLayer`. Then, there are a number of different `ViewModifiers` available to customize how it looks and behaves. Additionally, you can use expressions (`Exp`) to dynamically change the inputted values based on another data point.

Example from the app:
```Swift
CircleLayer(id: "access-areas-layer", source: "access-areas-source")
    .circleColor(.accessPointCircle)
    .circleRadius(Exp(.interpolate) {
        Exp(.linear)
        Exp(.zoom)
        0; 1
        11; 10
    })
```

The `interpolate` expression takes in any number of arguments. The first argument is the interpolation type, in this case `linear`. The second is the input to base the "stops" on. The following arguments are the stops themselves. They follow a format of: stop, value, stop, value. In the above example, it is easier to describe by using semicolons to keep the stop and the output zoom value on the same line.

## Making the Map Interactive
Mapbox provides tools for users to interact with the map, such as tapping, zooming, and panning. For this project, I added a `TapInteraction` on the access areas layer. When the user taps on an access point, it pulls up the `FeaturesetFeature` and the `InteractionContext`. In hindsight, I should have used this `InteractionContext` to get the coordinate for the access point, rather than referencing the optional value stored in the `feature.geometry` object.

Outside of what I have added, I was extremely impressed with the interaction available by default in Mapbox. Gestures such as pinch-to-zoom, swipe-to-pan, and two-finger swiping up to change the camera pitch are included. Mapbox allows you to create extremely powerful maps with very little actual code.

While building, I experimented with trying to highlight water bodies such as rivers, lakes, and ponds. However, the lines for rivers were extremely difficult to tap even at close zoom levels. To get around this, I added a "global" `TapInteraction`. Using the `InteractionContext`, I created a larger `CGRect` around the point and used the map to query for features in that `CGRect`. This ended up being extremely effective for getting the river lines. This feature didn't make it into the app because I couldn't figure out how to get the name of the river (or other water body) from this tap context. I was thinking I could use Mapbox-streets' `natural-labels` layer source, but I was not able to reference it. I am unsure if this was a limitation of the `.outdoors` map style I was using.
## Feature Filtering
Perhaps the most difficult part of creating this app was implementing the species filtering. Initially when I created this, I had uploaded my sources to a style in Mapbox Studio. However, I could not figure out how to apply a filter to a layer unless I added it programmatically in the app. This is why the datasets are included in the repository. Now, I believe that I could add a filter to a layer by getting the Map from the MapProxy, and adding 
```swift
map.setLayerProperty(for: "access-areas-layer", property: "filter", value: filter)
````
if I want to filter a layer stored in studio. I'll have to test this out to be sure though.

The other annoying aspect was the data format of the access points GeoJSON source. Unfortunately, this dataset only has each individual species of fish as its own key-value pair, rather than having an array of "species": ["list", "of", "species"]. In the future, I would probably create a script to update this dataset to add this species property, as well as keeping the individual key-value pairs for quick single-species referencing.