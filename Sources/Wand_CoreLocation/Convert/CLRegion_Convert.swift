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
/// let region: CLRegion = (lat, lon)|
///
@inline(__always)
postfix
public
func |(center: (lat: CLLocationDegrees, lon: CLLocationDegrees)) -> CLCircularRegion {
    .init(center: center|, radius: 111, identifier: String())
}

/// Convert
///
/// let region: CLRegion = center|
///
@inline(__always)
postfix
public
func |(center: CLLocationCoordinate2D) -> CLCircularRegion {
    .init(center: center, radius: 111, identifier: String())
}

/// Convert
///
/// let region: CLRegion = (center, radius)|
///
@inline(__always)
postfix
public
func |(region: (center: CLLocationCoordinate2D, radius: CLLocationDistance)) -> CLCircularRegion {
    .init(center: region.center, radius: region.radius, identifier: String())
}

/// Convert
///
/// let region: CLRegion = (center, radius, id)|
///
@inline(__always)
postfix
public
func |(region: (center: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String)) -> CLCircularRegion {
    .init(center: region.center, radius: region.radius, identifier: region.identifier)
}

#endif
