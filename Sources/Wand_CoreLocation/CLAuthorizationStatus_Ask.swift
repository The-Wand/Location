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

/// Ask
///
/// |{ (permissions: CLAuthorizationStatus) in
///
/// }
///
/// CLAuthorizationStatus.authorizedAlways | { (scope: CLAuthorizationStatus) in
///
/// }
///
extension CLAuthorizationStatus: AskingNil, Wanded {

    @inline(__always)
    public
    static 
    func wand<T>(_ wand: Wand, asks ask: Ask<T>) {

        //Save ask
        guard wand.answer(the: ask) else {
            return
        }

        //Request for a first time

        //Prepare context
        let source: CLLocationManager       = wand.obtain()
        let asking: CLAuthorizationStatus?  = wand.extract()

        //Make request
        #if APPCLIP || os(tvOS) || os(visionOS)
        
            source.requestWhenInUseAuthorization()

        #else

            switch asking {

                case .authorizedAlways:
                    source.requestAlwaysAuthorization()

                case .none, .authorizedWhenInUse:
                    source.requestWhenInUseAuthorization()

                default:
                    break
            }

        #endif

    }

}

@inline(__always)
@discardableResult
public
func | (request: CLAuthorizationStatus, handler: @escaping (CLAuthorizationStatus)->() ) -> Wand {
    Wand(for: request) | .every(handler: handler)
}

@inline(__always)
@discardableResult
public
func | (request: CLAuthorizationStatus, ask: Ask<CLAuthorizationStatus> ) -> Wand {
    Wand(for: request) | ask
}

#endif
