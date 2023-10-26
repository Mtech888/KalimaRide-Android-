//
//  MapTest.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 06/10/2023.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

struct NewView: View {
    var body: some View {
        NavigationView {
            AutocompleteView()
                .navigationBarTitle("Location Search")
        }
    }
}

struct AutocompleteView: View {
    @State private var isAutocompletePresented = false
    @State private var selectedPlaceName = ""
    @State private var selectedPlaceID = ""
    @State private var selectedPlaceAttributions = ""
    @State private var selectedPlaceCoordinate: CLLocationCoordinate2D?

    var body: some View {
        VStack {
            Button(action: {
                isAutocompletePresented.toggle()
            }) {
                Text("Launch Autocomplete")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .sheet(isPresented: $isAutocompletePresented, onDismiss: {
                // Handle the selected place or any other action upon dismissal.
                print("Selected Place Name: \(selectedPlaceName)")
                print("Selected Place ID: \(selectedPlaceID)")
                print("Selected Place Attributions: \(selectedPlaceAttributions)")
            }) {
                AutocompleteViewControllerWrapperr(selectedPlaceName: $selectedPlaceName,
                                                  selectedPlaceID: $selectedPlaceID,
                                                  selectedPlaceAttributions: $selectedPlaceAttributions,
                                                  selectedPlaceCoordinate: $selectedPlaceCoordinate)
            }
            
            // Display the map with the selected place
            if let placeCoordinate = selectedPlaceCoordinate {
                MapT(selectedPlaceCoordinate: placeCoordinate)
            }
        }
    }
}

struct AutocompleteViewControllerWrapperr: UIViewControllerRepresentable {
    @Binding var selectedPlaceName: String
    @Binding var selectedPlaceID: String
    @Binding var selectedPlaceAttributions: String
    @Binding var selectedPlaceCoordinate: CLLocationCoordinate2D?

    func makeUIViewController(context: Context) -> GMSAutocompleteViewController {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator

        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt64(UInt(GMSPlaceField.name.rawValue) |
                                                                   UInt(GMSPlaceField.placeID.rawValue)))
        autocompleteController.placeFields = fields

        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address  // Use .address to filter for address suggestions.
        autocompleteController.autocompleteFilter = filter

        return autocompleteController
    }

    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: Context) {
        // Update any settings if needed.
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, GMSAutocompleteViewControllerDelegate {
        var parent: AutocompleteViewControllerWrapperr

        init(_ parent: AutocompleteViewControllerWrapperr) {
            self.parent = parent
        }

        // Handle the user's selection.
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            parent.selectedPlaceName = place.name ?? ""
            parent.selectedPlaceID = place.placeID ?? ""
            parent.selectedPlaceAttributions = place.attributions?.string ?? ""
            
            // Set the selected place's coordinates
            parent.selectedPlaceCoordinate = place.coordinate

            viewController.dismiss(animated: true, completion: nil)
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            // TODO: Handle the error.
            print("Error: ", error.localizedDescription)
            viewController.dismiss(animated: true, completion: nil)
        }

        // User canceled the operation.
        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            viewController.dismiss(animated: true, completion: nil)
        }
    }
}

struct MapT: View {
    var selectedPlaceCoordinate: CLLocationCoordinate2D
    
    var body: some View {
        GoogleMapViewNew(selectedPlaceCoordinate: selectedPlaceCoordinate)
            .frame(height: 300)
    }
}

struct GoogleMapViewNew: UIViewRepresentable {
    var selectedPlaceCoordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: selectedPlaceCoordinate.latitude,
                                              longitude: selectedPlaceCoordinate.longitude,
                                              zoom: 50)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // Update the view if needed
    }
}
