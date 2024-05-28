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
import CoreLocation.CLLocationManager
import Wand

/// Obtain
///
/// let manager: CLLocationManager = nil|
///
extension CLLocationManager: Obtain {

    @inline(__always)
    public 
    static
    func obtain(by wand: Wand?) -> Self {

        let source = Self()
        
        source.desiredAccuracy = wand?.get(for: "CLLocationAccuracy") ??                                                     kCLLocationAccuracyThreeKilometers

        source.distanceFilter = wand?.get(for: "CLLocationDistance") ?? 100

        let wand = wand ?? Wand()
        source.delegate = wand.add(Delegate())

        return source
    }
    
}

public
extension CLLocationManager {
    
    public
    class Delegate: NSObject, CLLocationManagerDelegate, Wanded {

        public
        func locationManager(_ manager: CLLocationManager,
                             didUpdateLocations locations: [CLLocation]) {

            if let last = locations.last {
                isWanded?.add(last)
            }

            if locations.count > 1 {
                isWanded?.add(locations)
            }

        }

        public
        func locationManager(_ manager: CLLocationManager, 
                             didFailWithError error: Error) {

            isWanded?.add(error)
        }

        #if !os(visionOS)

            public
            func locationManager(_ manager: CLLocationManager,
                                 didChangeAuthorization status: CLAuthorizationStatus) {
                isWanded?.add(status)
            }

        #endif

    }
    
}

#endif
