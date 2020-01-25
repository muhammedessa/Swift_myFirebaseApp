 import Foundation
 import Firebase

 struct Person {
   
   let ref: DatabaseReference?
   let key: String
   let name: String
   let lname: String
   let age: String
   
   init(name: String, lname: String,    age: String, key: String = "") {
     self.ref = nil
     self.key = key
     self.name = name
     self.lname = lname
     self.age = age
   }
   
   init?(snapshot: DataSnapshot) {
     guard
       let value = snapshot.value as? [String: AnyObject],
       let name = value["name"] as? String,
       let lname = value["lname"] as? String,
       let age = value["age"] as? String else {
       return nil
     }
     
     self.ref = snapshot.ref
     self.key = snapshot.key
     self.name = name
     self.lname = lname
     self.age = age
   }
   
   func toAnyObject() -> Any {
     return [
       "name": name,
       "lname": lname,
       "age": age
     ]
   }
 }
