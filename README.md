
## **[Declarative Programming Language](https://github.com/The-Wand/Wand)**

|wand created to support all platfroms   
Prototype implemented on Swift

### Swift Package
[📦 |Location](https://github.com/The-Wand/Location)  

### ⚙️ Usage

```swift

//Request .authorizedWhenInUse permissions
CLAuthorizationStatus.authorizedWhenInUse | { (status: CLAuthorizationStatus) in
 
}

//Request location updates
//Uses .startUpdatingLocation()
|{ (location: CLLocation) in 

}

//Request .authorizedAlways permissions and only one location object
//Uses .requestLocation()
CLAuthorizationStatus.authorizedAlways | { (status: CLAuthorizationStatus) in
            
} | .one { (location: CLLocation) in 

}
```

### 💡 Idea
  Imagine that you have the black box that can give you an ```Any``` object.   
  You don't know what's already in the box and [what happens inside.](https://wikipedia.org/wiki/Encapsulation_(computer_programming))   
      
  Ask for object that you need with |

```bash
|{ (result: Object) in
            
}
```
```bash
ingredients | { (result: Object) in
            
}
```
```bash
ingredients | .one { (t: T) in
            
} | .every { (u: U) in

} | .while { (v: V) in
  true
}
```

### 🪄 Сoncept

Wand started from the idea about receiving anything in most efficient way.   
Add one sign to anything and retreive the result 📦

You ideas, comments and contributions are welcome |

[Alex Kozin](mailto:al@el-machine.com)  
[El Machine 🤖](https://el-machine.com)
