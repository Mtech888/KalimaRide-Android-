//
//  MapPath.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 25/10/2023.
//

class MapPath {
    
    var lat : Double?
    var lon : Double?
    var angle : Double?
   
    init() {}
    init(lat : Double?,lon : Double?,angle : Double?) {
        self.lat = lat
        self.lon = lon
        self.angle = angle
    }
}
