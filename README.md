
# Revista Correr - Digital

## Overview

Revista Correr is a digital magazine application, initially developed in **2013**. It serves as a dynamic platform for users to access editions, news, and schedules related to running events.

## Dependencies

This project relies on the following CocoaPods dependencies:

```ruby
pod "TSMessages"
pod "HMSegmentedControl"
pod "youtube-ios-player-helper", "~> 0.1.4"
pod 'Firebase/Core'
pod 'Firebase/Messaging'
pod 'Firebase/AdMob'
```

## Main Features

### Editions Table (`TableEdicoes.m`)
- Displays available magazine editions.
- Allows users to download and manage offline editions.
- Network checks using `Reachability`.
- User notifications using `TSMessages`.
- Downloaded editions are stored locally.

### News Details (`DatailsNew.h`)
- Displays detailed information about selected editions.

### Schedule Table (`TableJornal.m`)
- Displays running event schedules.
- Highlights important events.
- Provides details about event dates, locations, and distances.

### Image Download and Local Storage
- Images are downloaded asynchronously from URLs.
- Files are saved locally in specific directories.

## Key Functionalities

- **Internet Connectivity Check:** Ensures the app operates efficiently online and offline.
- **Download Manager:** Users can download magazine editions for offline reading.
- **User Alerts:** Alerts and messages are displayed via `TSMessages`.
- **Customization:** Supports multiple screen orientations and dynamic layouts.

## File Structure

- `TableEdicoes.m`: Manages the magazine editions list.
- `TableJornal.m`: Manages the running event schedule.
- `DatailsNew.h`: Manages detailed views for news or editions.
- `Reachability`: Handles network status monitoring.

## Setup

1. Clone the repository.
2. Run `pod install` in the project directory.
3. Open the `.xcworkspace` file in Xcode.
4. Configure Firebase for messaging and ads.

## Contact

For support or inquiries, please contact:

- **Developer:** Fabricio Padua  
- **Company:** Pro Master Solution  
- **Website:** [www.promastersolution.com.br](http://www.promastersolution.com.br)

## License

This project is licensed under the MIT License.
