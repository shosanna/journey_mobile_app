//
//  MemoryDetailViewController.swift
//  journey
//
//  Created by Zuzana Dostálová on 28/10/14.
//  Copyright (c) 2014 zuzana.dostalova. All rights reserved.
//

import UIKit
import MapKit

class MemoryDetailViewController: UIViewController {
    
    @IBOutlet weak var memoryDetailDate: UILabel!
    @IBOutlet weak var memoryDetailText: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var memory: Memory?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        memoryDetailText.text = memory!.text
        
        // 1
        let location = CLLocationCoordinate2D(
            latitude: memory!.latitude,
            longitude: memory!.longitude
        )
        // 2
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        //3
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = "Big Ben"
        annotation.subtitle = "London"
        mapView.addAnnotation(annotation)
    }
    }
