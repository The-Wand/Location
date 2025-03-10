///
/// Copyright 2020 Alexander Kozin
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Created by Alex Kozin
/// El Machine 🤖

#if canImport(CoreLocation)
import CoreLocation.CLLocation
import Wand

/// Convert
///
/// let location: CLLocation = coordinate|
///
@inline(__always)
postfix
public
func |(coordinate: CLLocationCoordinate2D) -> CLLocation {
    CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
}
/// Convert
///
/// let location: CLLocation = coordinate|
///
@inline(__always)
postfix
public
func |(coordinate: (lat: CLLocationDegrees, lon: CLLocationDegrees)) -> CLLocation {
    CLLocation(latitude: coordinate.lat, longitude: coordinate.lon)
}

/// Convert
///
/// let distance: CLLocationDistance? = to | from
///
@inline(__always)
public 
func | (to: CLLocationCoordinate2D?, from: CLLocationCoordinate2D?) -> CLLocationDistance? {
    guard let to, let from else {
        return nil
    }

    return to | from
}

/// Convert
///
/// let distance: CLLocationDistance = to | from
///
@inline(__always)
public 
func | (to: CLLocationCoordinate2D, from: CLLocationCoordinate2D) -> CLLocationDistance {
    to|.distance(from: from|)
}

/// Convert
///
/// let distance: CLLocationDistance = toLocation | fromLocation
///
@inline(__always)
public 
func | (to: CLLocation, from: CLLocation) -> CLLocationDistance {
    to.distance(from: from)
}

#endif
