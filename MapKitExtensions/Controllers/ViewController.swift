//
//  ViewController.swift
//  MapKitExtensions
//
//  Created by Rudolf Farkas on 08.08.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

import MapKit
import UIKit

class ViewController: UIViewController {
    var index = 0

    var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }

    func commonInit() {
        mapView = MKMapView(frame: .zero)
        view.addSubview(mapView)

//        print("cameraBoundary= \(String(describing: mapView.cameraBoundary))")
//        print("cameraBoundary.region= \(String(describing: mapView.cameraBoundary?.region.span))")
//        print("cameraZoomRange= \(String(describing: mapView.cameraZoomRange))")
//        print("cameraZoomRange.maxCenterCoordinateDistance= \(String(describing: mapView.cameraZoomRange.maxCenterCoordinateDistance))")
//        print("cameraZoomRange.minCenterCoordinateDistance= \(String(describing: mapView.cameraZoomRange.minCenterCoordinateDistance))")

        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            mapView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        ])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDetected))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        print("Tap on map to change region")
    }

    @objc func tapGestureDetected() {
        setRegion()
    }

    func setRegion() {
        print("setRegion \(index)")

        let coordGenève = CLLocationCoordinate2DMake(46.204391, 6.143158)
        let coordLausanne = CLLocationCoordinate2DMake(46.519962, 6.633597)
        let coordIstanbul = CLLocationCoordinate2DMake(41.01224, 28.976018)
        let coordTokyo = CLLocationCoordinate2DMake(35.658581, 139.745438)
        let coordHonolulu = CLLocationCoordinate2DMake(21.315603, -157.858093)

        let regions: [() -> Void] = [
            { self.mapView.setRegion(coordinate1: coordGenève, coordinate2: coordGenève) },
            { self.mapView.setRegion(coordinate1: coordGenève, coordinate2: coordLausanne) },
            { self.mapView.setRegion(coordinate1: coordIstanbul, coordinate2: coordTokyo) },
            { self.mapView.setRegion(coordinate1: coordLausanne, coordinate2: coordTokyo) },
            { self.mapView.setRegion(coordinate1: coordTokyo, coordinate2: coordHonolulu) },
        ]

        //print("cameraBoundary.region= \(String(describing: mapView.cameraBoundary?.region.span))")
//        print("\(mapView.camera.altitude)")
//        mapView.camera.altitude *= 1.2
//        print("\(mapView.camera.altitude)")

        regions[index]()
        index = (index + 1) % regions.count
    }
}
