//
//  DatePicker.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 20/09/2023.
//

import SwiftUI

struct DatePicker: View {
    @State var date: Date?
    var body: some View {
        ZStack {
            VStack {
                Text("Select Date")
                HStack{
                    DatePickertextField(placeholder: "Select Date", date: $date)
                        .font(.title)
                        .frame(height: 50)
                        .padding(.horizontal)
                    
                    Image("date-icon")
                        .padding(.horizontal)
                        
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.primary, lineWidth: 0.1)
            )
                .padding(.horizontal)
             

                
            }
        }
    }
}

struct DatePicker_Previews: PreviewProvider {
    static var previews: some View {
        DatePicker()
    }
}

struct DatePickertextField: UIViewRepresentable {
     let textfield = UITextField()
     let datePicker = UIDatePicker()
     let helper = Helper()
     var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter
    }()
    
    public var placeholder: String
    @Binding var date: Date?
    
    func makeUIView(context: Context) -> UITextField {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self.helper,
                                  action: #selector(self.helper.dateValueChanged), for: .valueChanged)
        self.textfield.placeholder = self.placeholder
        self.textfield.inputView = self.datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self.helper, action: #selector(self.helper.doneButtonAction))
        
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        self.textfield.inputAccessoryView = toolbar
        
        self.helper.dateChanged = {
            self.date = self.datePicker.date
        }
        
        self.helper.doneButtonTapped = {
            if self.date == nil {
                self.date = self.datePicker.date
            }
            self.textfield.resignFirstResponder()
        }
        return self.textfield
        
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if let selectedDate = self.date {
            uiView.text = self.dateFormatter.string(from: selectedDate)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Helper {
        public var dateChanged: (() -> Void)?
        public var doneButtonTapped: (() -> Void)?
        
        @objc func dateValueChanged() {
            self.dateChanged?()
        }
        
        @objc func doneButtonAction() {
            self.doneButtonTapped?()
        }
    }
    
    class Coordinator {
        
    }
}

