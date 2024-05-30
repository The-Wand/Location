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

#if canImport(WeatherKit)
import CoreLocation.CLLocation
import WeatherKit

import Any_
import WandCoreLocation
import Wand

import XCTest

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
class WeatherKit_Tests: XCTestCase {

//    func test_Nil_to_Weather_every() {
//        let e = expectation()
//        e.assertForOverFulfill = false
//
//        |.every { (weather: Weather) in
//            e.fulfill()
//        }
//
//        waitForExpectations()
//    }
//
//    func test_Nil_to_Weather_once() {
//        let e = expectation()
//
//        |.one { (weather: Weather) in
//            e.fulfill()
//        }
//
//        waitForExpecttachations()
//    }
//
//    func test_CLLocation_to_Weather_once() {
//        let e = expectation()
//
//      t  let location = CLLocation.any
//        location | .one { (weather: Weather) in
//            e.fulfill()
//        }
//
//        waitForExpectations()
//    }

    func test_WeatherService() {
        XCTAssertNotNil(WeatherService.self|)
    }

}
    
#endif
