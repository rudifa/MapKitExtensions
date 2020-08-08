//
//  MapKitE>xtensions.swift v.0.1.0
//  MapKitExtensions
//
//  Created by Rudolf Farkas on 08.08.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

import MapKit

extension CLLocationCoordinate2D {
    /// Find midpoint between self and other coordinate
    /// - Parameter other: other coordinate
    /// - Returns: midpoint
    func midPoint(to other: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        /// Find mid-longitude between longitudes x and y
        /// - Parameters:
        ///   - x: longitude degrees
        ///   - y: longitude degrees
        /// - Returns: longitude degrees
        func midLongitude(_ x: Double, _ y: Double) -> Double {
            let absdiff = abs(x - y)
            var mid = (x + y) / 2.0
            if absdiff > 180.0 {
                if mid > 0 { mid -= 180.0
                } else { mid += 180.0
                }
            }
            return mid
        }
        let latitude = (self.latitude + other.latitude) / 2.0
        let longitude = midLongitude(self.longitude, other.longitude)
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    /// Find coordinate span between self and other coordinate
    /// - Parameters:
    ///   - other: other coordinate
    ///   - times: augmentation factor
    ///   - minSpanDegrees: minimal span
    /// - Returns: coordinate span
    func span(to other: CLLocationCoordinate2D, augment times: Double = 1.4, minSpanDegrees: Double = 0.05) -> MKCoordinateSpan {
        /// Find span between longitudes x and y
        /// - Parameters:
        ///   - x: longitude degrees
        ///   - y: longitude degrees
        /// - Returns: longitude degrees
        func longitudeSpan(_ x: Double, _ y: Double) -> Double {
            var span = abs(x - y)
            if span > 180.0 {
                span = 360.0 - span
            }
            return span
        }
        let latitudeDelta = max(abs(latitude - other.latitude) * times, minSpanDegrees)
        let longitudeDelta = max(longitudeSpan(longitude, other.longitude) * times, minSpanDegrees)
        return MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
    }
}

extension MKMapView {
    /// Add annotation pin
    /// - Parameters:
    ///   - coordinate: pin position
    ///   - title: pin title
    func addAnnotation(coordinate: CLLocationCoordinate2D, title: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        addAnnotation(annotation)
    }

    /// Set map region spanning the two coordinates
    /// - Parameters:
    ///   - coordinate1: first coordinate
    ///   - coordinate2: second coordinate
    public func setRegion(coordinate1: CLLocationCoordinate2D, coordinate2: CLLocationCoordinate2D) {
        let center = coordinate1.midPoint(to: coordinate2)
        let span = coordinate1.span(to: coordinate2)
        let region = MKCoordinateRegion(center: center, span: span)
        setRegion(region, animated: true)

        print("coordinate1= \(coordinate1), coordinate2= \(coordinate2), center= \(center) span= \(span)")

        addAnnotation(coordinate: coordinate1, title: "1")
        addAnnotation(coordinate: coordinate2, title: "2")
    }
}

// let coordGenève = CLLocationCoordinate2DMake(46.204391, 6.143158)
// let coordLausanne = CLLocationCoordinate2DMake(46.519962, 6.633597)
// let coordTokyo = CLLocationCoordinate2DMake(35.658581, 139.745438)
// let coordHonolulu = CLLocationCoordinate2DMake(21.315603, -157.858093)

// mapView.setRegion(coordinate1: coordGenève)
// mapView.setRegion(coordinate1: coordGenève, coordinate2: coordLausanne)
// mapView.setRegion(coordinate1: coordTokyo, coordinate2: coordLausanne)
// mapView.setRegion(coordinate1: coordTokyo, coordinate2: coordHonolulu)
