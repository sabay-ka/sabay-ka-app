# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.5.0] - 2024-09-26
### Added

- `importLog` method of `RecorderBookmarks`
- `setParallelDownloadsLimit` method of `ContentStore`
- `registerOnMapViewMoveStateChanged` method of `GemMapController`
- `centerOnAreaRect` method of `GemView`
- `registerLandmarkStore` method of `LandmarkStoreService`
- `removeLandmarkStore` method of `LandmarkStoreService`
- `updateLandmark` method of `LandmarkStore`
- `clear` method of `MarkerCollection`
- `delete` method of `MarkerCollection`
- `getPointsGroupHComponents` method of `MarkerCollection`
- `getPointsGroupHead` method of `MarkerCollection`
- `indexOf` method of `MarkerCollection`
- `getBetterRouteTimeDistanceToFork` method of `NavigationService`
- `getNavigationInstruction` method of `NavigationService`
- `getNavigationParameters` method of `NavigationService`
- `getNavigationRoute` method of `NavigationService`
- `isNavigationActive` method of `NavigationService`
- `isSimulationActive` method of `NavigationService`
- `isTripActive` method of `NavigationService`
- `isTripActive` method of `NavigationService`
- `simulationMaxSpeedMultiplier` method of `NavigationService`
- `simulationMinSpeedMultiplier` method of `NavigationService`
- `diskSpaceUsedPerSecond` getter of `Recorder`
- `getAvailableDataTypes` getter of `Recorder`
- `recorderConfiguration` getter and setter of `Recorder`
- `status` getter of `Recorder`
- `chunkDurationSeconds`, `continuousRecording`, `overrideOverheatCheck`, `maxDiskSpaceUsed`, `keepMinSeconds`, `deleteOlderThanKeepMin`, `transportMode` fields of `RecorderConfiguration`
- `getTimeDistanceCoordinateOnRoute` method of `RouteBase`
- `isCurrentThreadMainThread` getter of `SdkSettings`
- overload for `==` operator and `hashCode` method for `BikeProfileElectricBikeProfile`, `BuildTerrainProfile`, `DepartureHeading`, `ElectricBikeProfile`, `EVProfile`, `CarProfile`
- `EntranceLocations` class
- `PTRoute` class
- `PTRouteSegment` class
- `PTRouteInstruction` class
- `PTBuyTicketInformation` class
- `PTAlert` class
- `RouteTrafficEvent` class

### Changed

- constructors of classes which should not be directly instantiated by the user are now private
- classes consisting only of static methods are abstract (`RouteBase`, `RoutingService`, `MapDetails`, `LandmarkStoreService`, `GuidedAddressSearchService`, `GenericCategories`, `SearchService`, `NavigationService`)
- all methods from `NavigationService` are static
- `getNextAddressDetailLevel` method of `GuidedAddressSearchService` returns `List<AddressDetailLevel>` instead of `List<int>`
- `getStoreContentList` method of `ContentStore` returns `Pair<List<ContentStoreItem>, bool>` instead of `Pair<ContentStoreItemList, bool>` and is now static
- `waypoints` getter of `RouteBase` transformed to `getWaypoints` method and takes a parameter of type `GetWaypointsOptions`
- `startRecording` and `stopRecording` methods of `Recorder` return `GemError` instead of `int`
- `exportLog` method of `RecorderBookmarks` returns `GemError` instead of `int`
- `id` getter from all enum extensions no longer return `-1` on default case
- `fromId` method of `ContactInfoFieldTypeExtension` no longer returns nullable `ContactInfoFieldType`, throwing exception on invalid input
- `isProtected` and `isUploaded` members of `LogMetadata` are getters instead of methods
- `MarkerCollectionRenderSettings` extends `MarkerRenderSettings`
- `TerrainProfile`, `ClimbSection`, `SurfaceSection`, `RoadTypeSection`, `SteepSection` and related enums moved to a new file

### Removed

- `create` method from classes where it is not appropriate
- empty classes (`ClimbSectionList`, `RouteCollection`, `MapViewRouteCollection`)
- `first` and `last` values from `ContentType` enum

### Fixed

- caching mechanism of Marker images
- `getId` method of `LandmarkCategory`
- `route` getter of `LogMetadata`
- `recorderConfiguration` getter of `Recorder`
- `current` getter of `GenericIterator`
- `buildTerrainProfile` field of `RoutePreferences` returned by `preferences` getter of `RouteBase` incorrect value

## [2.4.0] - 2024-09-04
### Added

- `addList` method of `MapViewMarkerCollections` 
- `devicePixelSize` method of `GemMapController` 
- `centerOnRoutePart` method of `MapView`
- `LandmarkJson` and `MarkerJson` for optimization 
- labels for `Markers`

### Removed
- `MarkerSketches` class and example

### Changed

- Moved some methods to safecall
- Callback functions with multiple parameters now have named parameters
- `remove` method of `MapViewMarkerCollections` renamed to `removeAt`

### Fixed

- `getRenderSettings` method of `MapViewRoutesCollection` returns `RouteRenderSettings` with correct values previously set with `setRenderSettings` method
- `cursorSelectionMarkers` method of `GemView`  
- `searchInArea` method of `SearchService`
- `getCoordinates` method of `Marker`
- `labelTextSize` and  `labelTextColor` of `MarkerRenderSettings`
- `indexOf` method of `MapViewMarkerCollections`
- `setRenderSettings` method of `MapViewMarkerCollections`
- `contains` method of `MapViewMarkerCollections`
- `isSketches` method of `MapViewMarkerCollections`
- `removeAt` method of `MapViewPathCollection`
- zoom out effect when tapping fast on markers

## [2.3.1] - 2024-08-09
### Added

- More fields in `RouteRenderSettings` 
- `NavigationStatus` enum
- Caching mechanism for images in `SdkSettings` class and `getImageById` method

### Changed

- Some fields in `MarkerRenderSettings` are no longer `nullable`
- `routes` parameter of `centerOnRoutes` is named and `nullable`
- `navigationStatus` method of `NavigationInstruction` class returns `NavigationStatus`
- `DataSource` methods return `GemError` instead of `int`

### Fixed

- `setMapStyleByPath` method of `MapViewPreferences` class
- `enableOverlay` and `disableOverlay` methods of `OverlayService` class
- `centerOnRoutes` method of `MapView` class
- waypoints getters of `RouteSegment` and `RouteBase` classes
- `removeLandmarkStoreId` method of `LandmarkStoreCollection` class
-  `RouteRenderSettings` constuctor

## [2.3.0] - 2024-08-05
### Added

- `setMapStyle` with binary data
- `removeAllLandmarks` method of `LandmarkStore` class
- `ExternalInfo` class
- `MapSceneObject` class
- `addList` method of `MarkerSketches` class 
- `MarkerSketches` example
- `enableTouchGestures` method of `MapViewPreferences` class
- More values to `RoadModifier`
- `RoadModifierExtension`

### Changed

- return type of method `hasChargeStop` of `EVRouteSegment` class from `int` to `bool`
- `cursorSelectionOverlays` method returns `OverlayItem`
- `OverlayService` methods return `GemError` instead of `int`
- `LandmarkStoreCollection` methods return `GemError` instead of `int`
- `MapViewMarkerCollections` methods return `GemError` instead of `int`
- `FollowPositionPreferences` methods return `GemError` instead of `int`
- `setImageFromIconId` method to `setImageFromIcon`. `GemIcon` parameter instead of `int`
- `ContentStoreItemStatus.downloadWaitingNetwork` ID to 5
- `DataType.gyroscope` ID to 1024
- `PositionRoadModifier` to `RoadModifier`
- `AnimationExtension` to `AnimationTypeExtension`
- `FixQualityExtension` to `PositionQualityExtension`
- `PositionRoadModifier` to `RoadModifier`
- `EMarkerLabelingModeExtension` to `MarkerLabelingModeExtension`
- `ERouteRenderOptionsExtension` to `RouteRenderOptionsExtension`
- `GenericCategoriesIDsExtension` to `GenericCategoriesIdExtension`
- `mapDetailsQuality` getter of `MapViewPreferences` returns `MapDetailsQualityLevel` instead of `int`
- More methods throws exception instead of `String`

### Fixed

- `getMapViewRoute`, `getLabel`, `setLabel` methods of `MapViewRoutesCollection` class
- `add`, `update`, `addTrips`, `sortOrder` methods of `RouteBookmarks`
- `fromJson` method of `EVProfile` class
- `clear` method of `MapViewMarkerCollections` class
- `timeStamp` getter of `Landmark` class
- `releaseView` Android native behaviour 
- `setMapRotationMode` IOS native behaviour

## [2.2.0] - 2024-07-10
### Added

- `getRouteStatus` and `CalculationRunning` methods of `RoutingService` class
- `getRoadInfoImage`, `getRoadInfo`, `hasRoadInfo`, `isExit` and `getExitDetails` methods of `Route Instruction` class,
- `getExtraInfo`, `setExtraInfo`, `setRouteListener` and `getRouteListener` methods of `Route` class
- `isCalculationRunning`, `getRouteStatus` methods of `RoutingService` class
- `verifyAppAuthorization` method of `SDKSettings` class

### Changed

- replaced `Time` object with `DateTime` dart object in following methods: get and set timeStamp for `Landmark` class, get timeStamp for `Route` object, get timeStamp for `RoutingPreferences` class

### Fixed

- `altitude` field of `GemPosition` class
- `geographicArea` method of `Landmark` class could cause app freeze

## [2.1.0] - 2024-06-17
### Added

- `PositionService` custom data source
- `uncategorizedLandmarkCategId` and `invalidLandmarkCategId` constants
- `getLogMetadata` method of `RecorderBookmarks` class and `LogMetadata` class
- `EVRoute` methods
- `SearchPreferences` overlays
- `SignpostItem` class
- `getTimeDistanceCoordinates` and `getWaypointsVia` methods of `Route` class
- `MapCamera` methods
- `GeographicArea` classes and methods
- `OverlayService` class and `getAvailableOverlays` method
- `captureAsImage` method of `MapController` class [iOS only]
- `getLatestOnlineMapVersion` method of `MapDetails` class

### Changed

- `selectMapObjects` method has been replaced with `setCursorScreenPosition`
- `asyncGetContentStoreList` and `asyncDownload` are now FFI methods
- images default size and format can be set with `setDefaultWidthHeightImageFormat` of `SdkSettings` class
- `getAbstractGeometry` method has a new parameter, `AbstractGeometryRenderSettings`
- `setCursorScreenPosition`, `skipAnimation`, `scroll`, `getHighlightArea` and `resetMapSelection` methods of `MapController` class are now non-async
- `setLiveDataSource` now returns GemError
- `segments` getter of `Route` class returns `List<RouteSegment>` instead of `RouteSegmentList`
- `getPath` method of `Route` class now retuns null path for invalid start and/or end instead of a Path with empty coordinates list
- `getTimeDistance` now has a bool parameter `activePart`

### Fixed

- `cancelSearch` issue which caused `onCompletedCallback` to not be called with `GemError.canceled`
- `polygonGeographicArea` getter of `Route` class
- `getRealisticNextTurnImage` method and `getTurnImage` of `Route` class
- `getCoordinatesAtPercent` static method of `Path` class
- `trafficEvents` method for `Route`
- `toEVRoute` method of `Route` class
- `routeTrack` getter of `Route` class
- `exportAs` method of `Path` class
- `cloneReverse` method of `Path` class
- `cloneStartEnd` method of `Path` class
- `getWaypoints` method of `Path` class
- `getElevationSamples` method of `RouteTerrainProfile` class behavior when callind with countSamples = 1
- `SignPostDetails` class getters
- `waypoints` getter of `RouteSegment` class
- `abstractGeometry` getter of `TurnDetails` class
- `containsLandmark` method of `LandmarkStore` class
- `getCategoryById` method of `LandmarkStore` class now returns null object for an invalid id
- `getLandmarks` method of `LandmarkStore` class now returns all landmarks for an unspecified categoryId
- `getLandmarkStoreById` method of `ContentStoreService` class now returns null object for an invalid id
- `Map` widget issues on Android which caused map to overlap other UI elements when rotating the device or opening a webview page over the one with the map
- `isFollowingPosition` getter of `MapController` class
- `accuracyCircleVisibility` getter and setter of `MapViewPreferences` class
- `getFieldName`, `getFieldValue`, `getFieldType` methods of `ContanctInfo` class when calling with an invalid index
- `getAllowOffboardServiceOnExtraChargedNetwork` method of `SdkSettings` class
- `getContourGeographicArea` method of `Landmark` class
- `extraInfo` getter of `Landmark` class

## [2.0.0] - 2024-05-22
### Added

- `releaseNative` method
- `RouteRenderSettings` optional parameter for `add` method of `MapViewRouteCollection`
- Map creation parameters: initial coordinates, zoomLevel, area and appAuthorization
- `Marker` class that allows drawing user defined polygons/polylines on the map
- `refreshContentStore` method
- `getContentParameters` method for `ContentStoreItem`

### Changed

- Imports
- Replaced methods with `get` and `set` prefixes with Dart get and set
- Renamed various members to match camelCase standard
- Replaced `create` factory with default constructor for multiple classes
- Multiple methods are now non-async
- SDK initialization changed from `GemKitPlatfor.instance.loadNative()` to `GemKit.initize()`
  - `appAuthorization` is now a paremeter of `GemKit.initize()`
- `setAllowConnection` of `SdkSettings` has now callback parameters of `OffboardListener` instead of `OffboardListener` object
- `update` method of `ContentUpdater` has now `onStatusUpdated` and `onProgressUpdate` parameters instead of `ProgressListener`
- `GemAnimation` has now `onCompleted` parameter instead of `ProgressListener`
- Replaced `ProgressListener` with `TaskHandler`
- Replaced error type from int to `GemError` enum
- Replaced `Rgba` with `Color`
- Replaced `width` and `height` image parameters with `Size`
- Replaced `LandmarkList`, `RouteList`, `ContentStoreItemList`, `LandmarkCategoryList` with Dart lists
- Added named parameters for some methods
- Renamed enums to match Dart standard

### Fixed

- `getImage`, `setImage`, `setExtraImage` methods of `Landmark`
- `ContactInfo` class
- `centerOnArea` of `GemMapController` class
- set and get language for `SdkSettings`
- Check against null the MapView, when activity is paused / resumed

## [1.9.0] - 2024-04-02
### Added

- Address Search
- Offboard Listener
- Content Updater for ContentStore
- `dispatchonmainThread` on safecallObject
- `canDoAutoUpdate` flag for offboardlistener constructor
- safe call for `gem_path` methods
- compare operator in Version class
- `dispatchOnMainThread` flag defaults true for `clear` method in Routingservice
- AllStoreCategoriesList field in SearchPreferences
- ExternalRendererMarkers
- `setMapLanguage` method
- `setCameraFocus` and `getCameraFocus` methods
- `getMapVersion` method
- `getExtraImage` method

### Changed

- Refactor - modified more methods to non async
- Removed err == 0 check from `onNotifyComplete` method on Search results
- `setAllowAutoMapUpdate` flag defaults to false
- initSdk to initCoreSdk
- dispatchOnMainThread to true for route removal and setImageFromIcon
- NavigationProgressListener to ProgressListener in `setNavigationRoadBlock`
- `add` method from LandmarkStoreCollection
- Landmark and landmark store methods to safecall
- `setNavigationRoadBlock` to static method
- `setImage` method for landmark to safecall
- The way images can be obtained

### Fixed

- `SetName` method in Landmark
- speed issue for position on Android
- Version class
- Map update/Resource update listener(Works on Android)
- Version's minor and major fields
- ElectricBikeProfile
- `setBuildingVisibility` method
- `addStoreCategoryList` method

## [1.8.0] - 2024-01-30
### Added

- `appDidEnterBackground`, `appDidBecomeActive` methods
- `onAngleMapUpdate`, `alignNorthUp` methods
- `cursorSelectionStreets`, `cursorSelectionOverlayItems` methods
- `getImageById`, `getImageUId`, `getImage`, `getImageByBitmap` methods
- `clearAllButMainRoute`, `centerOnMapRoutes` method
- `hasCoordinates`, `hasSpeed` methods
- `getNearestLocation` method
- arguments for `asyncDownload` method
- `addRoute` method
- `getOsVersion`
- automatic destructor
- `OffscreenBitmap` object
- position listener methods non async
- default values for `RoutePreferences`
- `GenericCategories` and `LandmarkListCategories` classes
- `FollowPositionPreferences`
- `[]` operator to `GemList`
- More methods in `RouteBookmarks`
- `routeRenderSettings` parameter when adding a route to view
- auto for `AndroidViewMode`
- check for calling methods before the Native is loaded

### Changed

- Made `LandmarkList` iterable
- Initialize the SDK earlier on Android
- Modified `cancelRoute` and `cancelNavigation` to non async
- Modified `centerOnArea`, `setCoordinates`, `centerOnRoutes` to non async
- Modified `removeLandmark` to non async
- Modified all `LandmarkStore` and `LandamrkStoreCollection` methods to non async
- Created a base class for lists ( `Iterable` )
- Made the getter for displayed routes non async
- Modified `getTurnInstruction` non async
- Made `cancelSearch` static
- Modified `ContentStoreItemList` to use GemList

### Fixed

- Activity lifecycle on Android
- Real position issue
- Path: clear and getArea issues
- Blackscreen issue on Android 12

## [Unreleased] - 2023-10-04
### Added

- More parameters to route preferences
- `MinDuration` parameter for `Recorder`
- `onRouteUpdated` and `onBetterRouteDetected` methods
- `getAbstractGeometryUId` method

### Changed

- Modified cancel search method to non async

### Fixed

- `cancelRoute` issue
- `setLiveDataSource` error throw

## [1.5.6] - 2023-09-06
### Added

- Content Store: Map Styles, Human Voices, Offline Maps
- Weather Service: Current Forecast, Hourly Forecast, Daily Forecast
- New map gesture: Long Press
- Recorder: Record route, export as .GPX
- SDK Settings: Unit System, Language, Set Navigation Voice, Allow Offboard Service on Charged Network
- Map Details: Get Country Flag by ISO code
- Map Styles: Apply Map Style, Get Current Map Style

### Changed

- SDK Settings methods are now static and non-async

### Fixed

- Fixed an issue where screen rotate on Android would cause loss of connection to SDK

## [1.5.2] - 2023-08-09
### Added

- Draw route
- Route preferences
- Route profile sections: Surfaces, Road types, Climb
- Route path
- WGS to screen coordinates converter

### Changed

- Modified Landmark to use direct FFI calls for getters.
- Bug fixing and improvements

## [1.5.1] - 2023-08-01
### Changed

- Bug fixing and improvements

## [1.5.0] - 2023-07-25
### Added

- Distance between 2 coordinates
- Image for landmarks
- Landmark selection on map
- `SearchService`: `searchInArea` & `searchAroundPosition`
- Route segments & route instructions
- `MapViewRouteCollection` methods
- Center camera on routes
- Abstract geometry image for navigation instructions
- Navigation events callback: new instruction, waypoint reached & destination reached
- Voice instructions with text-to-speech
- Animations for center camera on coordinates & follow position
- `PositionService`
- Follow position enter/exit events
- `LandmarkStoreContent`: custom stores
- `LandmarkStoreContent`: add, remove & contains methods

## [1.4.6] - 2023-07-22
### Changed

- Bug fixing and improvements

## [1.4.5] - 2023-07-18
### Changed

- Bug fixing and improvements

## [1.4.0] - 2023-07-13
### Added

- Start navigation simulation on route
- Cancel navigation
- Start follow position (for simulation only)
- Navigation instruction callback
- Landmark image
- Abstract geometry for navigation instructions
- Route time and distance

## [1.3.0] - 2023-07-07
### Added

- Activate highlight
- Deactivate highlight
- Route calculation
- Cancel route calculation
- Center camera on route

## [1.2.0] - 2023-07-05
### Added

- ExtraInfo field containing result distance, type, native name and English name

### Fixed

- Search working on Android and IOS

## [1.1.0] - 2023-07-04
### Changed

- Bug fixing and improvements

## [1.0.0] - 2023-06-30
Initial release
