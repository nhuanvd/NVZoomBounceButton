Pod::Spec.new do |s|
  s.name             = 'NVZoomBounceButton'
  s.version          = '1.0.0'
  s.summary          = 'Create zoom and bounce effect for your UIButton'

  s.homepage         = 'https://github.com/nhuanvd/NVZoomBounceButton'
  s.license          = 'MIT'
  s.author           = { 'Nhuan Vu Duc' => 'nhuanvd@live.com' }
  s.source           = { :git => 'https://github.com/nhuanvd/NVZoomBounceButton.git', :tag => '1.0.0' }
  s.source_files     = 'NVZoomBounceButton/NVZoomBounceButton.{h,m}'

  s.platform         = :ios, '7.0'
  s.requires_arc     = true

end
