Pod::Spec.new do |s|

    s.name                       = 'Graffiti'

    s.version                    = '1.0.0'

    s.summary                    = '图片涂鸦'

    s.homepage                   = 'https://github.com/JJCSoftDeveloper/Graffiti'

    s.license                    = { :type => 'MIT', :file => 'LICENSE' }

    s.author                     = { 'JJC' => '499927993@qq.com' }

    s.social_media_url           = 'https://weibo.com/1642366375'

    s.source                     = { :git => 'https://github.com/JJCSoftDeveloper/Graffiti.git', :tag => s.version }

    s.platform                   = :ios

    s.ios.deployment_target      = '8.1'

    s.dependency                 'Masonry'

    s.dependency                 'AFNetworking','3.2.0'

    s.dependency                 'JSONModel','1.7.0'

    s.dependency                 'MJRefresh','1.1.0'

    s.dependency                 'SDWebImage','4.3.3'

end