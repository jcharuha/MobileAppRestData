//
//  SubViewController.swift
//  Mobile Apps Project
//
//  Created by Joseph Charuhas on 12/6/24.
//
import Foundation
import UIKit
import WebKit
import MapKit


class SubViewController: UIViewController
{

    @IBOutlet weak var WVRestSite: WKWebView!
    @IBOutlet weak var MKRest: MKMapView!
    
    var subDetailRest: Restauraunt?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let urlString = subDetailRest?.rWebSite, let url = URL(string: urlString)
        {
            let request = URLRequest(url: url)
            WVRestSite.load(request)
        }
        
        if let address = subDetailRest?.rAddress
        {
            geocodeAndSetMapLocation(for: address)
        }
        
    }
    func geocodeAndSetMapLocation(for address:String)
    {
        
        let geocoder  = CLGeocoder()
        
        geocoder.geocodeAddressString(address)
        {
            [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error in geocoding address: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first, let location = placemark.location
            {
                let coordinate = location.coordinate
                
                let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
                self.MKRest.setRegion(region, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = address
                self.MKRest.addAnnotation(annotation)
            }
        }
    }
}


