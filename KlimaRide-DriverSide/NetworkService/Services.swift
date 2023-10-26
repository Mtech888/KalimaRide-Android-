//
//  Services.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 31/08/2023.
//

import SwiftUI
import CountryPicker
import PhotosUI

// MARK: - Sing Up ----------------------
class SingUpAPiMethod: ObservableObject {
    @Published var firstNameBindin: String = ""
    @Published var lastNameBinding: String = ""
    @Published var emailBinding: String = ""
    @Published var passwordBinding: String = ""
    @Published var confirmPasswordBinding: String = ""
    @Published var numberFieldBinding: String = ""
    @Published var countryCode: String? = nil
    @Published var loginSuccess = false
    @Published var isValidPhoneNumber: Bool = false
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showLoader = false
    @Published var userData: UserDataModel?
    
    func signUpUser() {
        let params: [String:Any] = ["signup_as": 1,
                                    "first_name": firstNameBindin,
                                    "last_name": lastNameBinding,
                                    "email": emailBinding,
                                    "country_code": countryCode ?? "",
                                    "phone": numberFieldBinding,
                                    "password": passwordBinding,
                                    "confirm_password": confirmPasswordBinding
        ]
        let headers : HTTPHeaders = ["Accept": "application/json"]
        
        let url = APIs.baseURL + APIs.signUp
        
        AF.request(url, method: .post, parameters: params, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("SIGNUP DATA IS: \(str ?? "")")
            do {
                let signUpModel = try JSONDecoder().decode(SignUpModel.self, from: data ?? Data())
                self.showLoader = true
                
                if signUpModel.status == false {
                    self.alertTitle = "Error"
                    self.alertMessage = "\(signUpModel.message)"
                    self.showAlert = true
                    self.showLoader = false
                } else if signUpModel.status == true {
                    print("Sign Up Success: \(signUpModel.message)")
                    self.alertTitle = "SUCCESS"
                    self.alertMessage = signUpModel.message
                    self.showAlert = true
                    self.loginSuccess = true
                    self.firstNameBindin = self.userData?.data?.firstName ?? ""
                    self.lastNameBinding = self.userData?.data?.lastName ?? ""
                    self.numberFieldBinding = self.userData?.data?.phone ?? "0"
                    self.countryCode = self.userData?.data?.countryCode ?? ""
                    self.showLoader = false
                }
            } catch {
                print(String(describing: error))
                self.showLoader = false
            }
        }
    }
}

// MARK: - Sing In ----------------------
class SignInApiMethod: ObservableObject {
    @Published var emailField: String = "Test5@gmail.com"
    @Published var passwordField: String = "123456"
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var navigateToAnotherView = false
    @Published var showLoader = false
    
   func signInUser() {
       let params: [String:Any] = ["login": emailField,
                                   "password": passwordField
       ]
       let headers : HTTPHeaders = ["Accept": "application/json"]
       
       let url = APIs.baseURL + APIs.login
       
       AF.request(url, method: .post, parameters: params, headers: headers).response { response in
           let data = response.data
           let str = String(data: data ?? Data(), encoding: .utf8)
           print("THE DATA IS: \(str ?? "")")
           do {
               let signInModel = try JSONDecoder().decode(SignInModel.self, from: data ?? Data())
               self.showLoader = true
               
               if signInModel.status == false {
                   self.alertTitle = "Error"
                   self.alertMessage = "\(signInModel.message)"
                   self.showAlert = true
                   self.showLoader = false
               } else if signInModel.status == true {
                   print(signInModel.data?.token ?? "")
                   UserDefaults.standard.set(signInModel.data?.token, forKey: "AUTH_TOKEN")
                   authToken = signInModel.data?.token
                   self.navigateToAnotherView = true
                   self.showLoader = false
               }
           } catch {
               print(String(describing: error))
           }
       }
    }
}

// MARK: - User Data -------------------------
class LoadUserDataAPIMethod: ObservableObject {
    @Published var image: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var phoneNumber: String = ""
    @Published var countryCode: String = ""
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showLoader = false
    let token = authToken
    
    func loadUserData() {
        let headers: HTTPHeaders = ["Accept": "application/json" , "Authorization": "Bearer \(token ?? "")"]
        
        let url = APIs.baseURL + APIs.userData
        
        AF.request(url, method: .get, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("THE USER DATA IS: \(str ?? "")")
            do {
                let userData = try JSONDecoder().decode(UserDataModel.self, from: data ?? Data())
                self.showLoader = true
                
                if userData.status == false {
                    print("ERROR: \(userData.message)")
                    self.alertMessage = "\(userData.message)"
                    self.showAlert = true
                    self.showLoader = false
                }
                else if userData.status == true {
                    print("SUCCESS: \(userData.message)")
                    print("User Data Token: \(self.token ?? "")")
                    DispatchQueue.main.async {
                        self.image = userData.data?.profileImage ?? ""
                        self.firstName = userData.data?.firstName ?? ""
                        self.lastName = userData.data?.lastName ?? ""
                        self.countryCode = userData.data?.countryCode ?? ""
                        self.phoneNumber = userData.data?.phone ?? ""
                        self.email = userData.data?.email ?? ""
                    }
                    self.showLoader = false
                }
            } catch {
                print(String(describing: error))
                self.showLoader = false
            }
        }
    }
}

// MARK: - Update Profile -----------------
class UpdateProfileApiMethod: ObservableObject {
    @Published var loginSuccess = false
//    @Published private(set) var selectedImage: UIImage? = nil
    @Published var image: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var phoneNumber: String = ""
//    @Published var profileImage: String = ""
    @Published var countryCode: String = ""
    @Published var brandName: String = ""
    @Published var modelName: String = ""
    @Published var numberPlate: String = ""
    @Published var latitude: Double = 0.00
    @Published var longitude: Double = 0.00
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showLoader = false
    @Published private var userData: UserDataModel?
    
    func updateProfile() {
        let token = authToken
        let params: [String:Any] = [
            "first_name": firstName,
            "last_name": lastName,
            "phone": phoneNumber,
            "country_code": countryCode,
            "device_type": "ios",
            "token": "DEVICE_TOKEN",
            "profile_image": image,
            ]
        
        let headers: HTTPHeaders = ["Accept": "application/json" , "Authorization": "Bearer \(token ?? "")"]
        
        let url = APIs.baseURL + APIs.updateProfile
        
        AF.request(url, method: .post, parameters: params, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("UPDATE DATA IS: \(str ?? "")")
            do {
                let updateProfileModel = try JSONDecoder().decode(UpdateProfileModel.self, from: data ?? Data())
                self.showLoader = true
                
                if updateProfileModel.status == false {
                    print("ERROR: \(updateProfileModel.message)")
                } else if updateProfileModel.status == true {
                    self.alertTitle = ""
                    self.alertMessage = "Your has been Updated"
                    self.showAlert = true
                    self.showLoader = false
                    print("SUCCESS: \(updateProfileModel.message)")
//                    print(updateProfileModel.data.fcmToken)
                    self.loginSuccess = true
//                    self.selectedImage = self.userData?.data.profileImage ?? ""
                    self.firstName = self.userData?.data?.firstName ?? ""
                    self.lastName = self.userData?.data?.lastName ?? ""
                    self.phoneNumber = self.userData?.data?.phone ?? "0"
                    self.countryCode = self.userData?.data?.countryCode ?? ""
                    self.image = self.userData?.data?.profileImage ?? ""
                    self.showLoader = false
                }
            } catch {
                print(String(describing: error))
                self.showLoader = false
            }
        }
    }
}

// MARK: - Change Passord -----------
class ChangePasswoedApiMethod: ObservableObject {
    @Published var currentPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showloader = false
    
   func changePassword() {
       let token = authToken
       let params: [String:Any] = ["old_password": currentPassword,
                                   "new_password": newPassword
       ]
       let headers: HTTPHeaders = ["Accept": "application/json" , "Authorization": "Bearer \(token ?? "")"]
       
       let url = APIs.baseURL + APIs.changePassword
       
       AF.request(url, method: .post, parameters: params, headers: headers).response { response in
           let data = response.data
           let str = String(data: data ?? Data(), encoding: .utf8)
           print("CHANGE PASSWORD DATA IS: \(str ?? "")")
           do {
               let changePasswordModel = try JSONDecoder().decode(ChangePasswordModel.self, from: data ?? Data())
               self.showloader = true
               
               if changePasswordModel.status == false {
                   print("ERROR: \(changePasswordModel.message)")
                   self.alertTitle = "Error"
                   self.alertMessage = "\(changePasswordModel.message)"
                   self.showAlert = true
                   self.showloader = false
               } else if changePasswordModel.status == true {
                   print("SUCCESS: \(changePasswordModel.message)")
                   self.alertTitle = ""
                   self.alertMessage = "\(changePasswordModel.message)"
                   self.showAlert = true
                   self.showloader = true
               }
           } catch {
               print(String(describing: error))
           }
       }
    }
}

// MARK: - Forgot Password ----------
class ForgotPasswordApiMethod: ObservableObject {
    @Published var email: String = ""
    @Published var verificationCode: String = ""
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var code: Int = 0
    @Published var verificationStatus: Bool = false
    let token = authToken
    
    func forgotPassword() {
        let headers: HTTPHeaders = ["Accept": "application/json" , "Authorization": "Bearer \(token ?? "")"]
        
        let url = APIs.baseURL + APIs.forgotPassword + email
        
        AF.request(url, method: .get, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("FORGOT PASSWORD DATA: \(str ?? "")")
            do {
                let forgotPasswordModel = try JSONDecoder().decode(ForgotPasswordModel.self, from: data ?? Data())
                print("Forgot Model: \(forgotPasswordModel)")
                if forgotPasswordModel.status == false {
                    self.alertTitle = "Error"
                    self.alertMessage = "\(forgotPasswordModel.message)"
                    self.showAlert = true
                    print("ERROR: \(forgotPasswordModel.message)")
                } else if forgotPasswordModel.status == true {
                    print("SUCCESS: \(forgotPasswordModel.message)")
//                    otpCode = forgotPasswordModel.data.code
                    self.code = forgotPasswordModel.data.code
                    self.verificationStatus = true
                    self.alertTitle = "Successs"
                    self.alertMessage = "\(forgotPasswordModel.message)"
                    self.showAlert = true
                    self.email = FPemail ?? ""
                }
            } catch {
                print(String(describing: error))
            }
        }
    }
}

// MARK: - Reset Passrod ------------
class ResetPasswordApiMethod: ObservableObject {
    @Published var email = FPemail ?? ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
    func resetPassword() {
        let token = authToken
        let params: [String:Any] = [
            "email": FPemail ?? "",
            "password": password,
            "password_confirmation": confirmPassword
        ]
        let headers: HTTPHeaders = ["Accept": "application/json" , "Authorization": "Bearer \(token ?? "")"]
        
        let url = APIs.baseURL + APIs.resetPasword
        
        AF.request(url, method: .post, parameters: params, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("Reset Passwrd data: \(str ?? "")")
            do {
                let resetPassData = try JSONDecoder().decode(ResetPasswordModel.self, from: data ?? Data())
                
                if resetPassData.status == false {
                    print("ERROR: \(resetPassData.message)")
                    self.alertTitle = ""
                    self.alertMessage = "\(resetPassData.message)"
                    self.showAlert = true
                } else if resetPassData.status == true {
                    print("SUCCESS: \(resetPassData.message)")
                    self.alertTitle = ""
                    self.alertMessage = "\(resetPassData.message)"
                    self.showAlert = true
                }
            } catch {
                print(String(describing: error))
            }
        }
    }
}

// MARK: - Logout ----------------
class LogoutAPIMethod: ObservableObject {
    let token = authToken
    @Published var navigate = false
    @Published var showloader = true
    
    func logout() {
        let headers: HTTPHeaders = ["Accept": "application/json" , "Authorization": "Bearer \(token ?? "")"]
        
        let url = APIs.baseURL + APIs.logout
        
        AF.request(url, method: .get, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("LOGOT DATA IS: \(str ?? "")")
            do {
                let logoutData = try JSONDecoder().decode(LogoutModel.self, from: data ?? Data())
                self.showloader = true
                
                if logoutData.status == false {
                    print("ERROR: \(logoutData.message)")
                    self.showloader = false
                }
                else if logoutData.status == true {
                    print("SUCCESS: \(logoutData.message)")
                    UserDefaults.standard.removeObject(forKey: "AUTH_TOKEN")
                    print("Token: \(self.token ?? "")")
                    self.navigate = true
                    self.showloader = false
                }
            } catch {
                print(String(describing: error))
                self.showloader = false
            }
        }
    }
}

// MARK: - My Vehicle ---------------
class MyVehicleApiMethod: ObservableObject {
    let token = authToken
    @Published var brandName: String = ""
    @Published var modelName: Int = 0
    @Published var numberPlate: String = ""
    @Published var myVehicleModel: MyVehicleModel? = nil
//    @Published var vhhicleData: [VehicleData]?
    
    func myVehicle() {
        let params: [String:Any] = ["action": "view"
        ]
        let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(token ?? "")"]
        
        let url = APIs.baseURL + APIs.myVehicle
        
        AF.request(url, method: .post, parameters: params ,headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("My Vehicle Information: \(str ?? "")")
            
            do {
                let myVehicelData = try JSONDecoder().decode(MyVehicleModel.self, from: data ?? Data())
//                let vehicleDetails = try JSONDecoder().decode(VehicleData.self, from: data ?? Data())
                
                if myVehicelData.status == false {
                    print("ERROR: \(myVehicelData.message)")
                }else if myVehicelData.status == true {
                    print("SUCCESS: \(myVehicelData.message)")
                    
                    DispatchQueue.main.async {
                        self.myVehicleModel = myVehicelData
                    }
                }
            } catch {
                print(String(describing: error))
            }
        }
    }
}

// MARK: - ADD Vehicle -----------
class AddVehicleApiMethod: ObservableObject {
    let token = authToken
    @Published var brandName: String = ""
    @Published var modelName: Int = 0
    @Published var numberPlate: String = ""
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var myVehicleModel: MyVehicleModel? = nil
    
    func addVehicle() {
        let params: [String:Any] = ["action": "create",
                                    "brand_name": brandName,
                                    "model_name": modelName,
                                    "number_plate": numberPlate
        ]
        let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(token ?? "")"]
        
        let url = APIs.baseURL + APIs.myVehicle
        
        AF.request(url, method: .post, parameters: params ,headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("Add Vehicle Data: \(str ?? "")")
            
            do {
                let myVehicelData = try JSONDecoder().decode(MyVehicleModel.self, from: data ?? Data())
                print(myVehicelData)
                if myVehicelData.status == false {
                    print("ERROR: \(myVehicelData.message)")
                    self.alertTitle = ""
                    self.alertMessage = "\(myVehicelData.message)"
                    self.showAlert = true
                }else if myVehicelData.status == true {
                    print("SUCCESS: \(myVehicelData.message)")
                    self.alertTitle = ""
                    self.alertMessage = "\(myVehicelData.message)"
                    self.showAlert = true
                }
            } catch {
                print(String(describing: error))
            }
        }
    }
}

// MARK: - Delete Vehicel ------------
class DeleteVehicleApiMethod: ObservableObject {
    let token = authToken
    @Published var vehicleId: Int?
    @Published var brandName: String = ""
    @Published var modelName: Int?
    @Published var numberPlate: String = ""
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var myVehicleModel: MyVehicleModel? = nil
    @Published var vhhicleData: [VehicleData]?
    
    func deleteVehicle(vehicleId: Int, _ completion: (() -> Void)? = nil) {
        let params: [String:Any] = ["action": "delete",
                                    "vehicle_id": vehicleId,
                                    "brand_name": brandName,
                                    "model_name": modelName ?? 0,
                                    "number_plate": numberPlate
        ]
        let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(token ?? "")"]
        
        let url = APIs.baseURL + APIs.myVehicle 
        
        AF.request(url, method: .post, parameters: params ,headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("Delete Vehicle Data: \(str ?? "")")
            
            do {
                let myVehicelData = try JSONDecoder().decode(MyVehicleModel.self, from: data ?? Data())
                print(myVehicelData)
                if myVehicelData.status == false {
                    print("ERROR: \(myVehicelData.message)")
                    self.alertTitle = ""
                    self.alertMessage = "\(myVehicelData.message)"
                    self.showAlert = true
                }else if myVehicelData.status == true {
                    print("SUCCESS: \(myVehicelData.message)")
                    self.alertTitle = ""
                    self.alertMessage = "\(myVehicelData.message)"
                    self.showAlert = true
                    completion?()
                }
            } catch {
                print(String(describing: error))
            }
        }
    }
}

// MARK: - EVENT BANNER --------

class EventBannerApiMethod: ObservableObject {
    let token = authToken
    @Published var eventtitle: String = ""
    @Published var eventImage: String = ""
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    @Published var eventBannerModel: EventBannerModel?
    
    func eventbanner() {
        
        let params: [String: Any] = [ "latitude": 31.5063786,
                                      "longitude": 74.3313217
        ]
        
        let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(token ?? "")"]
        
        let url = APIs.baseURL + APIs.eventBanner
        
        AF.request(url, method: .post, parameters: params, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("EVENT BANNER: \(str ?? "")")
            do {
                let eventBanner = try JSONDecoder().decode(EventBannerModel.self, from: data ?? Data())
                print(eventBanner)
                if eventBanner.status == false {
                    print("ERROR: \(eventBanner.message)")
                } else if eventBanner.status == true {
                    print("SUCCESS: \(eventBanner.message)")
                    DispatchQueue.main.async {
                        self.eventBannerModel = eventBanner
                    }
                }
            }catch {
                print(String(describing: error))
            }
        }
    }
}


// MARK: - SEARCH POST-------

class SearchPostAPiMethod: ObservableObject {
    let token = authToken
    var id = UUID()
    @Published var eventNameField: String = ""
    @Published var departureField: String = ""
    @Published var arrivalField: String = ""
    @Published var dateField: String = ""
    @Published var searchPost: Bool = false
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var userImage: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var rideType: String = ""
    @Published var rideTitle: String = ""
    @Published var leavingDate: String = ""
    @Published var leavingTime: String = ""
    @Published var seatsAvailable: String = ""
    @Published var perSeatPrice: String = ""
    @Published var myPostModel: SearchPostModel? = nil
    @State var driverDetails: SearchModelDriverDetails?
    @State var detail: Detail?
    @Published var oneWayRideStatus = false
    @Published var twoWayRideStatus = false
    @Published var recurringStatus = false
    

    func oneWayData() {
        let params: [String: Any] = [ "ride_type" : "One Way",
                                      "event_name": eventNameField,
                                      "departure_city": departureField,
                                      "arrival_city": arrivalField,
                                      "ride_date": dateField
        ]
        
        let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(token ?? "")"]
        let url = APIs.baseURL + APIs.searchPost

        AF.request(url, method: .post, parameters: params, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("SEARCH POST \(str ?? "")")
            
                do {
                    let searchPost = try JSONDecoder().decode(SearchPostModel.self, from: data ?? Data())
                    if searchPost.status == false {
                        print("No ride found")
                    } else if searchPost.status == true {
                        print("Ride Found")
                        self.searchPost = true
                        self.firstName = self.driverDetails?.first_name ?? ""
                        self.lastName = self.driverDetails?.last_name ?? ""
                        self.rideType = self.detail?.ride_type ?? ""
                        self.rideTitle = self.detail?.ride_title ?? ""
                        self.leavingDate = self.detail?.leaving_date ?? ""
                        self.leavingTime = self.detail?.leaving_time ?? ""
                        self.seatsAvailable = "\(self.detail?.number_of_seats ?? 0)"
                        self.perSeatPrice = "\(self.detail?.per_seat_price ?? 0) \(self.detail?.price_currency ?? "")"

                            DispatchQueue.main.async {
                                self.myPostModel = searchPost
                            }
                        
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
        }
    }
    
    func twoWayData() {
        let params: [String: Any] = [ "ride_type" : "Return",
                                      "event_name": eventNameField,
                                      "departure_city": departureField,
                                      "arrival_city": arrivalField,
                                      "ride_date": dateField
        ]
        
        let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(token ?? "")"]
        let url = APIs.baseURL + APIs.searchPost

        AF.request(url, method: .post, parameters: params, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("SEARCH POST \(str ?? "")")
            
                do {
                    let searchPost = try JSONDecoder().decode(SearchPostModel.self, from: data ?? Data())
                    if searchPost.status == false {
                        print("No ride found")
                    } else if searchPost.status == true {
                        print("Ride Found")
                        self.searchPost = true
                        self.firstName = self.driverDetails?.first_name ?? ""
                        self.lastName = self.driverDetails?.last_name ?? ""
                        self.rideType = self.detail?.ride_type ?? ""
                        self.rideTitle = self.detail?.ride_title ?? ""
                        self.leavingDate = self.detail?.leaving_date ?? ""
                        self.leavingTime = self.detail?.leaving_time ?? ""
                        self.seatsAvailable = "\(self.detail?.number_of_seats)"
                        self.perSeatPrice = "\(self.detail?.per_seat_price) \(self.detail?.price_currency)"

                            DispatchQueue.main.async {
                                self.myPostModel = searchPost
                                print(self.rideType)

                            }
                        
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
        }
    }
    
    func recurringData() {
        let params: [String: Any] = [ "ride_type" : "Recurring",
                                      "event_name": eventNameField,
                                      "departure_city": departureField,
                                      "arrival_city": arrivalField,
                                      "ride_date": dateField
        ]
        
        let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(token ?? "")"]
        let url = APIs.baseURL + APIs.searchPost

        AF.request(url, method: .post, parameters: params, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("SEARCH POST \(str ?? "")")
            
                do {
                    let searchPost = try JSONDecoder().decode(SearchPostModel.self, from: data ?? Data())
                    if searchPost.status == false {
                        print("No ride found")
                    } else if searchPost.status == true {
                        print("Ride Found")
                        self.searchPost = true
                        self.firstName = self.driverDetails?.first_name ?? ""
                        self.lastName = self.driverDetails?.last_name ?? ""
                        self.rideType = self.detail?.ride_type ?? ""
                        self.rideTitle = self.detail?.ride_title ?? ""
                        self.leavingDate = self.detail?.leaving_date ?? ""
                        self.leavingTime = self.detail?.leaving_time ?? ""
                        self.seatsAvailable = "\(self.detail?.number_of_seats)"
                        self.perSeatPrice = "\(self.detail?.per_seat_price) \(self.detail?.price_currency)"

                            DispatchQueue.main.async {
                                self.myPostModel = searchPost
                            }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
        }
    }
    
    
    func oneWayRide() {
        oneWayRideStatus = true
        let params: [String: Any] = [ "ride_type": "One Way",
                                      "event_name": eventNameField,
                                      "departure_city": departureField,
                                      "arrival_city": arrivalField,
                                      "ride_date": dateField
        ]
        
        let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(token ?? "")"]
        
        let url = APIs.baseURL + APIs.searchPost
        
        AF.request(url, method: .post, parameters: params, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("SEARCH POST \(str ?? "")")
            do{
                let searchPost = try JSONDecoder().decode(SearchPostModel.self, from: data ?? Data())
                if searchPost.status == false {
                    print("No ride found")
                    self.alertTitle = ""
                    self.alertMessage = "\(searchPost.message)"
                    self.showAlert = true
                } else if searchPost.status == true {
                    print("Ride Found")
                    self.alertTitle = ""
                    self.alertMessage = "\(searchPost.message)"
                    self.showAlert = true
                    self.searchPost = true
                }
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    func twoWayRide() {
        twoWayRideStatus = true
        let params: [String: Any] = [ "ride_type": "Return",
                                      "event_name": eventNameField,
                                      "departure_city": departureField,
                                      "arrival_city": arrivalField,
                                      "ride_date": dateField
        ]
        print(params)
        
        let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(token ?? "")"]
        
        let url = APIs.baseURL + APIs.searchPost
        
        AF.request(url, method: .post, parameters: params, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("SEARCH POST \(str ?? "")")
            do{
                let searchPost = try JSONDecoder().decode(SearchPostModel.self, from: data ?? Data())
                if searchPost.status == false {
                    print("No ride found")
                    self.alertTitle = ""
                    self.alertMessage = "\(searchPost.message)"
                    self.showAlert = true
                } else if searchPost.status == true {
                    print("Ride Found")
                    self.alertTitle = ""
                    self.alertMessage = "\(searchPost.message)"
                    self.showAlert = true
                    self.searchPost = true
                }
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    func recurringRide() {
        recurringStatus = true
        let params: [String: Any] = [ "ride_type": "Recurring",
                                      "event_name": eventNameField,
                                      "departure_city": departureField,
                                      "arrival_city": arrivalField,
                                      "ride_date": dateField
        ]
        print(params)
        
        let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(token ?? "")"]
        
        let url = APIs.baseURL + APIs.searchPost
        
        AF.request(url, method: .post, parameters: params, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("SEARCH POST \(str ?? "")")
            do{
                let searchPost = try JSONDecoder().decode(SearchPostModel.self, from: data ?? Data())
                if searchPost.status == false {
                    print("No ride found")
                    self.alertTitle = ""
                    self.alertMessage = "\(searchPost.message)"
                    self.showAlert = true
                } else if searchPost.status == true {
                    print("Ride Found")
                    self.alertTitle = ""
                    self.alertMessage = "\(searchPost.message)"
                    self.showAlert = true
                    self.searchPost = true
                }
            } catch {
                print(String(describing: error))
            }
        }
    }
}

// MARK: - RIDE DETAILS --------

class PostDetailsApiMethod: ObservableObject {
    let token = authToken
    @Published var image: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String =  ""
    @Published var ridetype: String = ""
    @Published var rideTitle: String = ""
    @Published var seatPrice: Int = 0
    @Published var rideDate: String = ""
    @Published var leavingDate: String = ""
    @Published var leavingTime: String = ""
    @Published var returningDate: String = ""
    @Published var returningTime: String = ""
    @Published var duration: String = ""
    @Published var availableSeats: Int = 0
    @Published var departureCity: String = ""
    @Published var arrivalCity: String = ""
    @Published var pickupLat: CGFloat = 0.0
    @Published var pickupLong: CGFloat = 0.0
    @Published var showLoader = false
    @Published var isStatus = false
    @Published var postDetailsModel: PostDetailsModel?
    
    func postDetails(id: Int) {
        
        let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(token ?? "")"]
        
        let url = APIs.baseURL + APIs.rideDetails + "\(id)"
        
        AF.request(url, method: .get, headers: headers).response { response in
            
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("POST DETAILS \(str ?? "")")
            
            do {
                let rideDetails = try JSONDecoder().decode(PostDetailsModel.self, from: data ?? Data())
                self.showLoader = true
                if rideDetails.status == false {
                    print("ERROR: \(rideDetails.message)")
                    self.showLoader = false
                } else if rideDetails.status == true {
                    print("SUCCESS: \(rideDetails.message)")
                    self.isStatus = true
                    DispatchQueue.main.async {
                        self.image = rideDetails.data?.user_details?.profile_image ?? ""
                        self.firstName = rideDetails.data?.user_details?.first_name ?? ""
                        self.lastName = rideDetails.data?.user_details?.last_name ?? ""
                        self.ridetype = rideDetails.data?.ride_type ?? ""
                        self.rideTitle = rideDetails.data?.ride_title ?? ""
                        self.rideDate = rideDetails.data?.ride_date ?? ""
                        self.seatPrice = rideDetails.data?.per_seat_price ?? 0
                        self.leavingDate = rideDetails.data?.leaving_date ?? ""
                        self.leavingTime = rideDetails.data?.leaving_time ?? ""
                        self.availableSeats = rideDetails.data?.number_of_seats ?? 0
                        self.departureCity = rideDetails.data?.departure_city ?? ""
                        self.arrivalCity = rideDetails.data?.arrival_city ?? ""
                        self.returningDate = rideDetails.data?.returning_date ?? ""
                        self.returningTime = rideDetails.data?.returning_time ?? ""
                        self.duration = rideDetails.data?.duration ?? ""
//                        self.pickupLat = rideDetails.data.pickupLatitude
//                        self.pickupLong = rideDetails.data.pickupLongitude
//                        print(self.firstName)
                        self.postDetailsModel = rideDetails
                        self.showLoader = false
                    }
                }
            } catch {
                print(String(describing: error))
            }
            
        }
    }
}

struct PickupPoints: Codable {
    var city, location, latitude, longitude, price : String
}

class RidePostApiMethod: ObservableObject {
    let token = authToken
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showLoader = false
    @Published var success = false
    @Published var rideTitle: String = ""
    @Published var perSeatPrice: Int = 0
    @Published var numberOfSeats: Int = 0
    @Published var departureCity: String = ""
    @Published var arrivalCity: String = ""
    @Published var rideDate: String = ""
    @Published var leavingDate: String = ""
    @Published var leavingTime: String = ""
    @Published var returningDate: String = ""
    @Published var returningTime: String = ""
    @Published var duration: String = ""
    @Published var pickupPoint: [PickupPoints] = []
    @Published var ridePostModel: RidePostModel? = nil
    @Published var oneWayRide = false
    @Published var returnRide = false
    @Published var recurringRide = false
    
    func ridePostOneWay() {
        let data = try? JSONEncoder().encode(self.pickupPoint)
        let pickupPointString = String(data: data ?? Data(), encoding: .utf8) ?? ""
        let params: [String:Any] = [
            "action": "create",
            "post_id": 1,
            "ride_type": "One Way",
            "ride_title": rideTitle,
            "per_seat_price": perSeatPrice,
            "number_of_seats": numberOfSeats,
            "departure_city": departureCity,
            "arrival_city": arrivalCity,
            "leaving_date": leavingDate,
            "leaving_time": leavingTime,
            "pickup_points": pickupPointString
        ]
        print("PARAMS \(params)")
        let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(token ?? "")"]
        let url = APIs.baseURL + APIs.ridePost
        
        AF.request(url, method: .post, parameters: params, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("Ride Post Data One Way: \(str ?? "")")
            
            do {
                let ridePostData = try JSONDecoder().decode(RidePostModel.self, from: data ?? Data())
                print("model response \(ridePostData)")
                self.showLoader = true
                if ridePostData.status == false {
                    print("ERROR: \(ridePostData.message)")
                    self.alertTitle = ""
                    self.alertMessage = "\(ridePostData.message)"
                    self.showAlert = true
                    self.showLoader = false
                } else if ridePostData.status == true {
                    print("SUCCESS: \(ridePostData.message)")
                    self.alertTitle = ""
                    self.alertMessage = "\(ridePostData.message)"
                    self.showAlert = true
                    self.success = true
                    self.showLoader = false
                }
            } catch {
                print(String(describing: "One Ride Error \(error)"))
                self.showLoader = false
            }
        }
    }
    
    func ridePostReturn() {
        let data = try? JSONEncoder().encode(self.pickupPoint)
        let pickupPointString = String(data: data ?? Data(), encoding: .utf8) ?? ""
        let params: [String:Any] = [
            "action": "create",
            "post_id": 1,
            "ride_type": "Return",
            "ride_title": rideTitle,
            "per_seat_price": perSeatPrice,
            "number_of_seats": numberOfSeats,
            "departure_city": departureCity,
            "arrival_city": arrivalCity,
            "ride_date": rideDate,
            "leaving_date": leavingDate,
            "leaving_time": leavingTime,
            "returning_date": returningDate,
            "returning_time": returningTime,
            "duration": duration,
            "pickup_points": pickupPointString,
        ]
        let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(token ?? "")"]
        let url = APIs.baseURL + APIs.ridePost
        
        AF.request(url, method: .post, parameters: params, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("Ride Post Data Return: \(str ?? "")")
            
            do {
                let ridePostData = try JSONDecoder().decode(RidePostModel.self, from: data ?? Data())
                self.showLoader = true
                
                if ridePostData.status == false {
                    print("ERROR: \(ridePostData.message)")
                    self.alertTitle = ""
                    self.alertMessage = "\(ridePostData.message)"
                    self.showAlert = true
                    self.showLoader = false
                } else if ridePostData.status == true {
                    print("SUCCESS: \(ridePostData.message)")
                    self.alertTitle = ""
                    self.alertMessage = "\(ridePostData.message)"
                    self.showAlert = true
                    self.success = true
                    self.showLoader = false
                }
            } catch {
                print(String(describing: error))
                self.showLoader = false
            }
        }
    }
    
    func ridePostRecurring() {
        let data = try? JSONEncoder().encode(self.pickupPoint)
        let pickupPointString = String(data: data ?? Data(), encoding: .utf8) ?? ""
        let params: [String:Any] = [
            "action": "create",
            "post_id": 1,
            "ride_type": "Recurring",
            "ride_title": rideTitle,
            "per_seat_price": perSeatPrice,
            "number_of_seats": numberOfSeats,
            "departure_city": departureCity,
            "arrival_city": arrivalCity,
            "ride_date": rideDate,
            "leaving_date": leavingDate,
            "leaving_time": leavingTime,
            "returning_date": returningDate,
            "returning_time": returningTime,
            "duration": duration,
            "pickup_points": pickupPointString,
        ]
        let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(token ?? "")"]
        let url = APIs.baseURL + APIs.ridePost
        
        AF.request(url, method: .post, parameters: params, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("Ride Post Data: \(str ?? "")")
            
            do {
                let ridePostData = try JSONDecoder().decode(RidePostModel.self, from: data ?? Data())
                self.showLoader = true
                
                if ridePostData.status == false {
                    print("ERROR: \(ridePostData.message)")
                    self.alertTitle = ""
                    self.alertMessage = "\(ridePostData.message)"
                    self.showAlert = true
                    self.showLoader = false
                } else if ridePostData.status == true {
                    print("SUCCESS: \(ridePostData.message)")
                    self.alertTitle = ""
                    self.alertMessage = "\(ridePostData.message)"
                    self.showAlert = true
                    self.success = true
                    self.showLoader = false
                }
            } catch {
                print(String(describing: error))
                self.showLoader = false
            }
        }
    }
    
    func ridePostData() {
        let params: [String:Any] = [
            "action": "view"
        ]
        let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(token ?? "")"]
        let url = APIs.baseURL + APIs.ridePost
        
        AF.request(url, method: .post, parameters: params, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("Ride Post View Data: \(str ?? "")")
            
            do {
                let ridePostData = try JSONDecoder().decode(RidePostModel.self, from: data ?? Data())
                self.showLoader = true
                if ridePostData.status == false {
                    print("ERROR: \(ridePostData.message)")
                    self.alertTitle = ""
                    self.alertMessage = "\(ridePostData.message)"
                    self.showAlert = true
                    self.showLoader = false
                } else if ridePostData.status == true {
                    print("SUCCESS: \(ridePostData.message)")
                    DispatchQueue.main.async {
                        self.ridePostModel = ridePostData
                        self.showLoader = false
                    }
                }
            } catch {
                print(String(describing: error))
                self.showLoader = false
            }
        }
    }
}


class BookRideApiMethod: ObservableObject {
    let token = authToken
    @Published var seatPrice: Int = 0
    @Published var noOfSeats: Int = 0
    @Published var subtotal: Int = 0
    @Published var seats: Int = 0
    @Published var status: String = ""
    @Published var bookRideModel: BookRideModel? =  nil
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showLoader = false
    @Published var postRideModel: PostDetailsModel? = nil
    
    func bookRide() {
        let params: [String:Any] =  [  "action": "view",
                                       "post_id": 17,
                                       "pickup_point_id": 37,
                                      "number_of_seats": noOfSeats,
                                      "per_seat_price": seatPrice,
                                      "total_seats_price": subtotal,
                                       "price_currency": "$",
                                       "booking_id": 2,
                                       "status": status
        ]
        let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(token ?? "")"]
        let url = APIs.baseURL + APIs.bookRide
        
        AF.request(url, method: .post, parameters: params, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("BOOK RIDE: \(str ?? "")")
            do{
                let bookdRide = try JSONDecoder().decode(BookRideModel.self, from: data ?? Data())
                self.showLoader = true
                if bookdRide.status == false {
                    print("Error: \(bookdRide.message)")
                    self.alertTitle = "ERROR"
                    self.alertMessage = "\(bookdRide.message)"
                    self.showAlert = true
                    self.showLoader = false
                }else if bookdRide.status == true {
                    print("Succses: \(bookdRide.message)")
                    self.alertTitle = "SUCCESS"
                    self.alertMessage = "\(bookdRide.message)"
                    self.showAlert = true
                    self.showLoader = false
                    self.seats = self.postRideModel?.data?.number_of_seats ?? 0
                    self.seatPrice = self.postRideModel?.data?.per_seat_price ?? 0
                }
                DispatchQueue.main.async {
                    self.bookRideModel = bookdRide
                }
            }catch {
                print(String(describing: error))
                self.showLoader = false
            }
        }
    }
}

class BookingStatusChangeApiMethod: ObservableObject {
    let token = authToken
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showLoader = false
    
    func changeStatus(bookingId: Int, newStatus: String) {
        let params: [String:Any] =  [
            "booking_id": bookingId,
            "status": newStatus
        ]
        let headers: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(token ?? "")"]
        let url = APIs.baseURL + APIs.bookingStatusChange
        
        AF.request(url, method: .post, parameters: params, headers: headers).response { response in
            let data = response.data
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("BOOKING STATUS CHANGE DATA: \(str ?? "")")
            do{
                let bookingStatus = try JSONDecoder().decode(BookingStatusChangeModel.self, from: data ?? Data())
                self.showLoader = true
                if bookingStatus.status == false {
                    print("Error: \(bookingStatus.message)")
                    self.alertTitle = "ERROR"
                    self.alertMessage = "\(bookingStatus.message)"
                    self.showAlert = true
                    self.showLoader = false
                }else if bookingStatus.status == true {
                    print("Succses: \(bookingStatus.message)")
                    self.alertTitle = "SUCCESS"
                    self.alertMessage = "\(bookingStatus.message)"
                    self.showAlert = true
                    self.showLoader = false
                }
            }catch {
                print(String(describing: error))
                self.showLoader = false
            }
        }
    }
}
