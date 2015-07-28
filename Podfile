source 'https://github.com/CocoaPods/Specs'

platform :ios, '8.0'

inhibit_all_warnings!
use_frameworks!

target 'ovo', :exclusive => true do
    # Add Application pods here
    pod 'Alamofire'
    pod 'Result'
    pod 'Kingfisher'
    pod 'TraktModels', :git => 'https://github.com/marcelofabri/TraktModels.git'
    pod 'FloatRatingView', :git => 'https://github.com/strekfus/FloatRatingView.git'
    pod 'BorderedView'
    pod 'SwiftyUserDefaults'
end

target :unit_tests, :exclusive => true do
  link_with 'UnitTests'
  pod 'Nimble'
  pod 'OHHTTPStubs'
end

