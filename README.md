# RunTracker
Currently in progress...

## Description
WalkTracker is basic app that allows a user to log walk/runs. The app is able to provide user stats such as run speed, distance, altitude changes, and pace.  

## Future Updates/Features In Progress:
- Total Stats in the profile view
- Update UI
- HealthKit implementation + Read/Writing data: 6-Minute-Walk, Walking asymmetry, previous history of fall, walking speed, walking steadiness, and step length. 
- Fall Risk Assessment + Explainations??
- Implementing 5x sit to stand test to further develop fall risk assessment. 

### Technologies Used
- CoreLocation Framework
- MapKit
- SwiftData
- Swift/SwiftUI
- Xcode

## Features
- Real-time Location Tracking: Utilizes smartphone sensors to track the route of a user's run in real-time.
- User Privacy/Safety: All data is stored locally, no location data is sent out.
- History Log: Have all runs stored in a single place.
- Run Stats: See run speed, distance, pace, and elevation gain during a run. 

## Installation
- Clone the repo:
 ```git clone https://github.com/wilsonckm/WalkTracker.git```
- Open the project in Xcode.
- Project must be run on device and not a simulator.

## Usage
The purpose of this app/feature is to allow users to save runs locally on their phone, providing ease of mind on user privacy and safety.

## Challenges

A few notable barriers throughout the project... 

#### SwiftData and Non-Simple Datatypes
Attempts to directly save an array of CLLocationCorrdinate2D into SwiftData resulted in a "persisted object" error, therefore, it was decided to mirror the database as simple datatypes as a workaround and expand it accordingly to what was necessary. 

#### MVVM for SwiftData?
The process of displaying/working with SwiftData in a MVVM context seemed to add additional complexity, requiring the need to create a custom initializer in the view to pass to the viewModel only to be sent back into the view. Personally, it felt like it added additional complexity that would make things more convoluted with minimal benefits. Additonally, having a viewModel for every single view would effectively double the number of files and things to maintain. 

With the mindset of "Code is not an asset, it is a liability," Less things to manage would be easiest even though having logic for a screen completely may be the most organized.

This was a great resource that I found later on regarding SwiftUI Architecture.
https://www.youtube.com/watch?v=MvNlsx5AP7k&ab_channel=DevCommunity

Therefore, ModelView was opted for for the scope of this project. Having a few aggregate root objects/observable objects that are shared between multiple views would make things easier! 

And the decision to add a new ObservableObject should stem from the integration of a new source of truth instead of having a new screen (such as in MVVM)

#### Familiarizing with CoreLocation + MapKit
At first, the decision was to only capture an array of CLLocationCoordinate2D so that it would be nicely implemented with Mapkit's MapPolyline to capture the user's route. However, upon further reading, it was noted that CLLocation was a better fit/allowed for greater expansion into capturing speed, altitude, and accuracy. 

## Contributing
Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are greatly appreciated.

-Fork the Project

-Create your Feature Branch 
``` (git checkout -b feature/AmazingFeature) ```

-Commit your Changes 
```(git commit -m 'Add some AmazingFeature')```

-Push to the Branch 
```(git push origin feature/AmazingFeature)```

-Open a Pull Request
