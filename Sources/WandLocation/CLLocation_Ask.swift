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
@_exported
import CoreLocation.CLLocation
@_exported
import Wand

/// Ask
///
/// |{ (location: CLLocation) in
/// 
/// }
/// 
/// CLAuthorizationStatus.authorizedAlways | { (location: CLLocation) in
/// 
/// }
///
/// T.one | E.one | { (error: Error?) in
/// }
/// Ask
///
/// |{ (permissions: CLAuthorizationStatus) in
///
/// }
///
/// CLAuthorizaÅÅtionStatus.authorizedAlways | { (scope: CLAuthorizationStatus) in
///
/// }
///
extension CLLocation: @retroactive Ask.Nil, @retroactive Wanded {

    @inline(__always)
    public
    static
    func ask<C, T>(with scope: C, ask: Ask<T>) -> Core {

        let wand = Core.to(scope)
        guard wand.append(ask: ask) else {
            return wand
        }

        //Request for a first time

        //Prepare context
        let source: CLLocationManager = wand.get()

        //Set the cleaner
        wand.setCleaner(for: ask) {
            source.stopUpdatingLocation()
        }

        //Make request
        return wand | ask.dependency { (status: CLAuthorizationStatus) -> Bool in

            guard status != .notDetermined else {
                return true
            }

            #if os(tvOS)

                source.requestLocation()

            #else

                if ask.once {
                    source.requestLocation()
                } else {
                    source.startUpdatingLocation()
                }

            #endif

            return false
        }

    }

}

#endif
