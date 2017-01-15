Pod::Spec.new do |s|
  s.name        = "ShoppingData"
  s.version     = "0.0.1"
  s.summary     = "data for shopping"
  s.homepage    = "https://github.com/sperev/ShoppingData"
  s.license     = { :type => "MIT" }
  s.authors     = { "Sergei Perevoznikov" => "sperev@bk.ru" }

  s.requires_arc = true
  s.ios.deployment_target = "8.0"
  s.source   = { :git => "https://github.com/sperev/ShoppingData.git", :tag => s.version }
  s.source_files = "Sources/*.swift", "Sources/**/*.swift"
  s.dependency 'ShoppingModels', '0.0.2'
end
