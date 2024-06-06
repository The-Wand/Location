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
import WandCoreLocation
import Wand

import XCTest

final
class CLLocation_Tests: XCTestCase {

    weak 
    var wand: Wand?

    func test_Nil_to_CLLocation_every() {
        let e = expectation()
        e.assertForOverFulfill = false

        |.every { (location: CLLocation) in
            e.fulfill()
        }

        waitForExpectations()
    }

    func test_Nil_to_CLLocation_once() {
        let e = expectation()

        |.one { (location: CLLocation) in
            e.fulfill()
        }

        waitForExpectations()
    }

    func test_Options_to_CLLocation() {
        let e = expectation()

        let accuracy = Set([
            kCLLocationAccuracyBestForNavigation,
            kCLLocationAccuracyBest,
            kCLLocationAccuracyNearestTenMeters,
            kCLLocationAccuracyHundredMeters,
            kCLLocationAccuracyKilometer,
            kCLLocationAccuracyThreeKilometers
        ]).first!

        let distance: CLLocationDistance = .random(in: 100...420)

        let wand: Wand = ["CLLocationAccuracy": accuracy,
                          "CLLocationDistance": distance]
        self.wand = wand

        wand | .one { (location: CLLocation) in
            e.fulfill()
        }

        let context = wand.context

        let manager: CLLocationManager = wand.obtain()
        XCTAssertEqual(manager.desiredAccuracy,
                       context["CLLocationAccuracy"] as! CLLocationAccuracy)
        XCTAssertEqual(manager.distanceFilter,
                       context["CLLocationDistance"] as! CLLocationDistance)

        waitForExpectations()
    }

    func test_CLLocation_to_Ask() {
        let e = expectation()

        let location =  CLLocation.any

        location | .one { (asked: CLLocation) in

            if asked === location {
                e.fulfill()
            }

        }
        self.wand = location.isWanded

        waitForExpectations()
    }

    @available(macOS, unavailable)
    func test_CLAuthorizationStatus_to_CLLocation() {
        let e = expectation()

        //Request location with specified CLAuthorizationStatus
        let status =  CLAuthorizationStatus.authorizedWhenInUse

        status | .one { (location: CLLocation) in

            //Check that auth status is correct
            let received: CLAuthorizationStatus = location.wand.get()!
            if received == .authorizedWhenInUse || received == .authorizedAlways {
                e.fulfill()
            }

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
