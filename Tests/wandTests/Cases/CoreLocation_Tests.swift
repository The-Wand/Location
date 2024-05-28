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
import CoreLocation
import XCTest

import WandCoreLocation
import Wand

class CoreLocation_Tests: XCTestCase {
    
//        func test_Nil_to_CLLocation_every() {
//            let e = expectation()
//            e.assertForOverFulfill = false
//    
//            |.every { (location: CLLocation) in
//                e.fulfill()
//            }
//    
//            waitForExpectations()
//        }
    
        func test_Nil_to_CLLocation_once() {
            let e = expectation()
            e.assertForOverFulfill = true
    
            |.one { (location: CLLocation) in
                e.fulfill()
            }
    
            waitForExpectations()
        }
    
//        func test_CLLocationManager() {
//            XCTAssertNotNil(CLLocationManager.self|)
//        }
    
    }
    
    #endif

//    func test_CLLocation() {
//        let e = expectation()
//        e.assertForOverFulfill = false
//
//        |.one { (location: CLLocation) in
//            e.fulfill()
//        }
//
//        waitForExpectations()
//    }
//
//    func test_CLLocation_options() {
//        let e = expectation()
//        e.assertForOverFulfill = false
//
//        let accuracy = CLLocationAccuracy.any(in: [
//            kCLLocationAccuracyBestForNavigation,
//            kCLLocationAccuracyBest,
//            kCLLocationAccuracyNearestTenMeters,
//            kCLLocationAccuracyHundredMeters,
//            kCLLocationAccuracyKilometer,
//            kCLLocationAccuracyThreeKilometers
//        ])
//        let distance = ((100...420)| as Int)| as Double
//
//        let pipe: Wand = ["CLLocationAccuracy": accuracy,
//                              "CLLocationDistance": distance]
//        let piped = pipe.context
//
//        pipe | .one { (location: CLLocation) in
//            e.fulfill()
//        }
//
//
//        let manager: CLLocationManager = pipe.obtain()
//        XCTAssertEqual(manager.desiredAccuracy,
//                       piped["CLLocationAccuracy"] as! CLLocationAccuracy)
//        XCTAssertEqual(manager.distanceFilter,
//                       piped["CLLocationDistance"] as! CLLocationDistance)
//
//        waitForExpectations()
//    }
//
//    func test_CLAuthorizationStatus() {
//        let e = expectation()
//        e.assertForOverFulfill = false
//
//        |.one { (status: CLAuthorizationStatus) in
//            e.fulfill()
//        }
//
//        waitForExpectations()
//    }
//
//    func test_CLLocationManager() {
//        XCTAssertNotNil(self| as CLLocationManager)
//    }
//
//}
