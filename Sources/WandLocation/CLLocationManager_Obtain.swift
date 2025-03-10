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
import CoreLocation.CLLocationManager
import Wand

/// Obtain
///
/// let manager: CLLocationManager = nil|
///
extension CLLocationManager: @retroactive Obtain {

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

extension CLLocationManager {

    class Delegate: NSObject, CLLocationManagerDelegate, Wanded {

        @available(iOS 6.0, *)
        @inlinable
        func locationManager(_ manager: CLLocationManager,
                             didUpdateLocations locations: [CLLocation]) {
            print("Loc")
            if let last = locations.last {
                isWanded?.add(last)
            }

            if locations.count > 1 {
                isWanded?.add(locations)
            }

        }

        //        @available(iOS 3.0, *)
        //        @inlinable
        //        func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        //
        //        }
        //
        //        @available(iOS 3.0, *)
        //        @inlinable
        //        func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        //
        //        }

        @available(iOS 2.0, *)
        @inlinable
        func locationManager(_ manager: CLLocationManager,
                             didFailWithError error: Error) {

            isWanded?.add(error)
        }

#if !os(visionOS)

        @available(iOS, introduced: 4.2, deprecated: 14.0)
        @inlinable
        func locationManager(_ manager: CLLocationManager,
                             didChangeAuthorization status: CLAuthorizationStatus) {
            isWanded?.add(status)
        }

#endif

#if !os(tvOS) && !os(visionOS) && !os(watchOS)

        @inlinable
        @available(iOS 6.0, *)
        @available(tvOS, unavailable)
        @available(visionOS, unavailable)
        @available(watchOS, unavailable)
        func locationManager(_ manager: CLLocationManager,
                             didFinishDeferredUpdatesWithError error: (any Error)?) {
            isWanded?.add(error)
        }

        @available(iOS 8.0, *)
        @available(tvOS, unavailable)
        @available(visionOS, unavailable)
        @available(watchOS, unavailable)
        @inlinable
        func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
            isWanded?.add(visit)
        }

        ///CLBeacon
//        @available(iOS 13.0, *)
//        @inlinable
//        func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
//
//        }
//
//        @available(iOS 13.0, *)
//        @inlinable
//        func locationManager(_ manager: CLLocationManager, didFailRangingFor beaconConstraint: CLBeaconIdentityConstraint, error: any Error) {
//
//        }
//
//        ///CLRegion
//        @available(iOS 7.0, *)
//        @inlinable
//        func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
//
//        }
//

        @available(iOS 4.0, *)
        @available(tvOS, unavailable)
        @available(visionOS, unavailable)
        @available(watchOS, unavailable)
        @inlinable
        func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
            print("didEnterRegion")
            isWanded?.add(region,
                          for: Ask<CLCircularRegion>.Keys.didEnter.rawValue)
        }

        @available(iOS 4.0, *)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        @available(visionOS, unavailable)
        @inlinable
        func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
            print("didExitRegion")
            isWanded?.add(region,
                          for: Ask<CLCircularRegion>.Keys.didExit.rawValue)
        }

#endif
//
//        @available(iOS 5.0, *)
//        @inlinable
//        func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
//
//        }
//
//        @available(iOS 4.0, *)
//        @inlinable
//        func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: any Error) {
//
//        }

    }

}

#endif
