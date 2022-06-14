[![Swift Version][swift-image]][swift-url]

# Test Assignment
<br />
<p align="center">
  <p align="center">
    Display news feed and stock tickers.
  </p>
</p>

### Features

- [x] First section
    - The first section should contain list of horizontal tickers with symbol and price. Price should be presented as
- [x] The second section
  - The second section should have a horizontal news list. Each cell has to contain new title and image. (First 6 news from json file)
- [x] The last section
  - The last section has to be a vertical list with remaining news. Cell has to contain title, date, image and full descriptions.

### Technical Specification

The app is written and built with this following hardware and sofware specification

- XCode Version : Version 13.2.1 (13C100)
- macOS Version: macOS BigSur 11.6.6 (20G624)
- Swift Version: 5
- Minium iOS Version : 13.0
- Depedency Manager : Cocoapods

### Installation
Run ```$pod install``` in your project directory.
Open ```*.xcworkspace``` and build.

### Development Specification

The app is written in UIKit and MVVM architecture.
Use Combine framework to fetch and display data.
Use Codable to decode JSON data and ##CSV.swift## for CSV reader.
Use ##UICollectionViewCompositionalLayout## for data visualisation.

### Reference

https://raw.githubusercontent.com/dsancov/TestData/main/stocks.csv
https://saurav.tech/NewsAPI/everything/cnn.json

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
