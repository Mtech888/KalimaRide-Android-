//
//  CountryPicker.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 01/10/2023.
//

import SwiftUI
import CountryPicker

struct CountryPicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = CountryPickerViewController

    let countryPicker = CountryPickerViewController()
    let mutatingWrapper = MutatingWrapper()

    @Binding var country: Country?

    func makeUIViewController(context: Context) -> CountryPickerViewController {
        countryPicker.selectedCountry = "TR"
        countryPicker.delegate = context.coordinator
        return countryPicker
    }

    func updateUIViewController(_ uiViewController: CountryPickerViewController, context: Context) {
        //
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, CountryPickerDelegate {
        var parent: CountryPicker
        init(_ parent: CountryPicker) {
            self.parent = parent
        }
        func countryPicker(didSelect country: Country) {
            parent.country = country
            parent.mutatingWrapper.countrySelected?(country)
        }
    }
    
    func onCountrySelected(_ action: @escaping ((Country) -> Void)) -> CountryPicker {
        self.mutatingWrapper.countrySelected = action
        return self
    }
}

extension CountryPicker {
    class MutatingWrapper {
        var countrySelected: ((Country) -> Void)? = nil
    }
}

