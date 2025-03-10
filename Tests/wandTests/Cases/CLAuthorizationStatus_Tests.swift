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

#if canImport(CoreLocation) /* // */ && !targetEnvironment(simulator) && !os(macOS) //Test with Host App
import CoreLocation

import Any_
import WandLocation
import Wand

import XCTest

@available(macOS, unavailable)
final
class CLAuthorizationStatus_Tests: XCTestCase {

    weak
    var wand: Wand?

    func test_Nil_to_CLAuthorizationStatus() {
        let e = expectation()

        |.while { (status: CLAuthorizationStatus) in

            guard
                status == .authorizedAlways ||
                status == .authorizedWhenInUse
            else
            {
                return true
            }

            e.fulfill()

            return false
        }

        waitForExpectations(timeout: .default * 4)
    }

    func test_Request_to_CLAuthorizationStatus() {
        let e = expectation()

        let request = Set<CLAuthorizationStatus>([
            .authorizedAlways,
            .authorizedWhenInUse
        ]).first!

        request | .while { (status: CLAuthorizationStatus) in

            if request == .authorizedAlways &&
               status == .authorizedAlways ||

                request == .authorizedWhenInUse &&
               (status == .authorizedWhenInUse || status == .authorizedAlways)
            {
                e.fulfill()
                return false
            }

            return true

        }

        waitForExpectations(timeout: .default * 4)
    }

    func test_CLAuthorizationStatus_one_Performance() {

        measure(metrics: .default) {

            |.one { (status: CLAuthorizationStatus) in
                print("🧪 \(status)")
            }

        }

    }

    func test_CLAuthorizationStatus_subscribe_Performance() {

        measure(metrics: .default) {

            |.every { (status: CLAuthorizationStatus) in
                print("🧪 \(status)")
            }

        }

    }


    func test_closed() throws {
        XCTAssertNil(wand)
    }

}

#endif
