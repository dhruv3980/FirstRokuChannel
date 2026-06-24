# FirstRokuChannel

My first Roku TV application built using **BrightScript** and **SceneGraph**. This project was created for learning Roku application development and understanding how streaming applications work on the Roku platform.

The application demonstrates navigation, content listing, entitlement validation, and video playback workflows commonly used in OTT applications.

## Features

* Side Navigation Menu
* Live TV Section
* Video On Demand (VOD) Section
* Content Listing
* Entitlement Verification
* Video Playback
* SceneGraph Components
* API Integration
* Task Nodes for Background Operations
* Custom UI Components

## Application Flow

### Live TV Flow

1. User selects **Live TV** from the navigation menu.
2. Live content information is displayed.
3. User clicks **Watch Now**.
4. Entitlement API is called.
5. If access is granted, the player launches.
6. Video playback starts.

### Video On Demand Flow

1. User selects **Video On Demand** from the navigation menu.
2. Landscape content cards are displayed.
3. User selects a video.
4. Video details are shown.
5. User clicks **Watch Now**.
6. Entitlement API is called.
7. If access is granted, the player launches.
8. Video playback starts.

## Project Structure

```text
components/
│
├── MainScene.xml
├── MainScene.brs
│
├── HomeNode.xml
├── HomeNode.brs
│
├── sideBarItem.xml
├── sideBarItem.brs
│
├── rowItem.xml
├── rowItem.brs
│
├── listnode.xml
├── listnode.brs
│
├── liveTaskNode.xml
├── liveTaskNode.brs
│
├── playerTaskNode.xml
├── playerTaskNode.brs
│
├── playerTaskSecondNode.xml
├── playerTaskSecondNode.brs
│
├── checkentitlementNode.xml
├── checkentitlementNode.brs
│
├── checksecondentitlementNode.xml
├── checksecondentitlementNode.brs
│
└── tasknode.xml
    tasknode.brs
```

## Technologies Used

* Roku SceneGraph
* BrightScript
* Roku Video Player
* Roku Task Nodes
* REST APIs

## Learning Objectives

This project was developed to learn:

* Roku application architecture
* SceneGraph UI development
* Focus management
* Navigation handling
* API integration
* Video streaming workflows
* Entitlement-based content access
* Custom component creation
* Background task execution

## Screens

### Navigation Menu

Allows switching between Live TV and Video On Demand sections.

### Live TV

Displays live content and allows users to start playback after entitlement validation.

### Video On Demand

Displays VOD content in card-based layouts and supports playback after entitlement validation.

## Future Improvements

* Authentication Flow
* Search Functionality
* User Profiles
* Watchlist
* DRM Integration
* Better UI/UX
* Analytics Integration
* Subscription Management

## Author

Dhruv Sahu

Built as a learning project to explore Roku TV application development and streaming platform architecture.
