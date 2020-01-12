# BreakingBad
A list of Breaking Bad characters and their details

### Api Links
- https://breakingbadapi.com/api/characters

### Development Platform
- iOS 12.0 (Minimum deployment traget) and XCode 11.3
- Swift 5.1

### Targets
- BreakingBad - Main application target
- BreakingBadTests - Unit testing target

### Swift libraries 
- Quick.Nimble - for BDD testing
- GCDWebServer - for mock server
- SDWebImage - for image caching
- ReachabilitySwift - for reachability checking
[For simpicity I also include all the pod projects in the repo]


### Instruction to run
- Download/ Clone the project from URL or .Zip
- open BreakingBad.xcworkspace and run in the simulator or divice

### Swift architecture
<img width="642" alt="Screenshot 2019-09-30 at 10 45 25" src="https://user-images.githubusercontent.com/1453658/65918729-49a99a80-e3d2-11e9-8451-91937068221c.png">

- The application is build with MVVM-C (Model-View-ViewModel and Coordinator) design pattern. Use of coordinator patern for navigation. Therefore viewcontrollers are free from navigation. 
- Universal App that support different layouts for iPhone and iPad in horizental and vertical orientation.

### Code Coverage
- Current code coverage is 85%

### Features
- After launching the application it will make an api call to retrive A list of Breaking Bad characters
- Taping a charecter will show details about the selected character
- The user should be able to search for a character by name
- The user should be able to filter characters by season appearance 
