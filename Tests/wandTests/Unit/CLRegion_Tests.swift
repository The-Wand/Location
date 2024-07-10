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

#if canImport(CoreLocation) && !targetEnvironment(simulator) //Test with Host App
import CoreLocation

import Any_
import Wand_CoreLocation
import Wand

import XCTest

final
class CLRegion_Tests: XCTestCase {

    weak 
    var wand: Wand?

    func test_CLRegion_didEnterRegion_every() {
        let e = expectation()
        e.assertForOverFulfill = false

        |.didEnter { (region: CLRegion) in
            e.fulfill()
        }

        waitForExpectations()
    }

    func test_CLRegion_didEnterRegion_every() {
        let e = expectation()
        e.assertForOverFulfill = false

        |.didExit { (region: CLRegion) in
            e.fulfill()
        }

        waitForExpectations()
    }

    func test_CLLocation_one_Performance() {

        measure(metrics: .default) {

            |.one { (location: CLLocation) in
                print("🧪 \(location)")
            }

        }

    }

    func test_CLLocation_subscribe_Performance() {

        measure(metrics: .default) {

            |.every { (location: CLLocation) in
                print("🧪 \(location)")
            }

        }

    }

    func test_CLLocationManager() {
        XCTAssertNotNil(CLLocationManager.self|)
    }

    func test_closed() throws {
        XCTAssertNil(wand)
    }

}

#endif
