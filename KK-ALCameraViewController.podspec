Pod::Spec.new do |spec|
  spec.name               = "KK-ALCameraViewController"
  spec.version            = "4.0.1"
  spec.summary            = "Forked and modified version of ALCameraViewController."
  spec.swift_version      = '5.0'
  spec.source             = { :git => "https://github.com/kkieffer/ALCameraViewController.git", :tag => spec.version.to_s }
  spec.requires_arc       = true
  spec.platform           = :ios, "9.0"
  spec.license            = "MIT"
  spec.source_files       = "ALCameraViewController/**/*.{swift}"
  spec.resources          = ["ALCameraViewController/ViewController/ConfirmViewController.xib", "ALCameraViewController/CameraViewAssets.xcassets", "ALCameraViewController/CameraView.strings"]
  spec.homepage           = "https://github.com/kkieffer/ALCameraViewController"
  spec.author             = { "Alex Littlejohn" => "alexlittlejohn@me.com", "Kevin Kieffer" => "" }
  spec.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }
end
