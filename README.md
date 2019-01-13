# Setup

### Dependencies
- cocoapods
- fastlane

## Step 1
#### Installing all dependencies.
  - Open the terminal
  - Install [cocoapods](https://guides.cocoapods.org/using/getting-started.html#installation) running this command
    ```sh
    $ sudo gem install cocoapods
    ```
  - Install [fastlane](https://docs.fastlane.tools/getting-started/ios/setup/)
    ```sh
    $ xcode-select --install
    $ sudo gem install fastlane -NV
    $ sudo gem install scan
    ```

## Step 2
#### Running UnitTests and UITests.
- Running by Xcode
    - Open project and press ⌘ + U
- Running by Fastlane
    - Open terminal and navigate to the project root folder
    - Run the following command
        ```sh
        $ fastlane tests
        ```
