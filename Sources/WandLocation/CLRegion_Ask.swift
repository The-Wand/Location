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

public
extension Ask {

    class DidEnter: Ask {
    }

    class DidExit: Ask {
    }

}

@available(tvOS, unavailable)
@available(visionOS, unavailable)
public
extension Ask where T: CLCircularRegion {

    public
    enum Keys: String {
        case didEnter = "CLCircularRegion.didEnter",
             didExit = "CLCircularRegion.didExit"
    }

    @inline(__always)
    static
    func didEnter(handler: @escaping (T)->() ) -> DidEnter {
        .init(once: false, for: Keys.didEnter.rawValue, handler: handler)
    }

    @inline(__always)
    static
    func didExit(handler: @escaping (T)->() ) -> DidExit {
        .init(once: false, for: Keys.didExit.rawValue, handler: handler)
    }

}

@available(iOS 7.0, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@available(visionOS, unavailable)
extension CLCircularRegion: @retroactive Ask.T, @retroactive Wanded {

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

        //Make request
        return wand | ask.dependency { (status: CLAuthorizationStatus) -> Bool in

            guard status != .notDetermined else {
                return true
            }

            //TODO: Fix cleaners
            let cleaner: ( ()->() )? = nil

            let region: CLCircularRegion? = wand.get()
            let regions: [CLCircularRegion]? = wand.get()

            //Make request
            if let region {

                source.startMonitoring(for: region)

                //Set the cleaner
                wand.setCleaner(for: ask) {
                    source.stopMonitoring(for: region)
                }

            }

            if let regions {

                regions.forEach {
                    source.startMonitoring(for: $0)
                }

                //Set the cleaner
                wand.setCleaner(for: ask) {
                    cleaner?()
                    regions.forEach {
                        source.stopMonitoring(for: $0)
                    }
                }

            }

            return false
        }


    }

}

#endif
