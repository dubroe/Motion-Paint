class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @mainViewController = MainViewController.alloc.init
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(@mainViewController)
    @window.makeKeyAndVisible
    true
  end
end
