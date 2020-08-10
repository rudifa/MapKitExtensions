# MapKitExtensions

Helper functions for setting the MKMapView regions

### Unsolved problem:

In the test case
```
    { self.mapView.setRegion(coordinate1: coordLausanne, coordinate2: coordTokyo) }
```
the `MKMapView` maximal zoom-in seems to be limited, so that Lausanne and Tokyo are just outside of the map region.

This problem is not present in a playground, using the same `MapKitExtensions` and test cases.

