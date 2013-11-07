Pod::Spec.new do |s|

  s.name         = "NodeSpriteKit"
  s.version      = "0.0.1"
  s.summary      = "Write SpriteKit games in JavaScript the node.js way."

  s.description  = <<-DESC
                  NodeSpriteKit allows game developers to use the SpriteKit
                  framework in iOS 7 from node.js programs.
                   DESC

  s.homepage     = "https://github.com/kwhinnery/NodeSpriteKit"
  s.license      = 'MIT'
  s.author       = { 
    "Kevin Whinnery" => "kevin.whinnery@gmail.com" 
  }
  s.platform     = :ios, '7.0'
  s.source       = { 
    :git => "https://github.com/kwhinnery/NodeSpriteKit.git", 
    :tag => "0.0.1" 
  }

  s.source_files  = 'NodeSpriteKit/Framework/*.{h,m}'
  s.frameworks  = 'SpriteKit', 'JavaScriptCore'
  s.requires_arc = true
  s.dependency 'SocketRocket', '0.3.1-beta2'

end
