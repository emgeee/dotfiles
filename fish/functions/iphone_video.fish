
# From https://stackoverflow.com/questions/25797990/capture-ios-simulator-video-for-app-preview
function iphone_video
  set fname $argv[1]
  xcrun simctl io booted recordVideo $fname
end
