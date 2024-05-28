///
/// Copyright © 2020-2024 El Machine 🤖
/// https://el-machine.com/
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
/// 1) LICENSE file
/// 2) https://apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Created by Alex Kozin
/// 2020 El Machine
#if canImport(CoreLocation)
import CoreLocation.CLLocation
import Wand

/// Convert
///
/// let location: CLLocation = coordinate|
///

//CLLocation
@inline(__always)
public 
postfix func |(coordinate: CLLocationCoordinate2D) -> CLLocation {
    CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
}

//CLLocationCoordinate2D
@inline(__always)
public 
postfix func |(degrees: (CLLocationDegrees, CLLocationDegrees)) -> CLLocationCoordinate2D {
    CLLocationCoordinate2D(latitude: degrees.0, longitude: degrees.1)
}

@inline(__always)
public 
postfix func |(location: CLLocation) -> CLLocationCoordinate2D {
    location.coordinate
}

//CLLocationDistance
@inline(__always)
public 
func | (to: CLLocationCoordinate2D?, from: CLLocationCoordinate2D?) -> CLLocationDistance? {
    guard let to = to, let from = from else {
        return nil
    }

    return to | from
}

@inline(__always)
public 
func | (to: CLLocationCoordinate2D, from: CLLocationCoordinate2D) -> CLLocationDistance {
    to|.distance(from: from|)
}

@inline(__always)
public 
func | (to: CLLocation, from: CLLocation) -> CLLocationDistance {
    to.distance(from: from)
}

#endif
