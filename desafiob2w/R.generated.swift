//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try font.validate()
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `purleApp`.
    static let purleApp = Rswift.ColorResource(bundle: R.hostingBundle, name: "purleApp")
    
    /// `UIColor(named: "purleApp", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func purleApp(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.purleApp, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `Pacifico-Regular.ttf`.
    static let pacificoRegularTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Pacifico-Regular", pathExtension: "ttf")
    
    /// `bundle.url(forResource: "Pacifico-Regular", withExtension: "ttf")`
    static func pacificoRegularTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.pacificoRegularTtf
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 1 fonts.
  struct font: Rswift.Validatable {
    /// Font `Pacifico-Regular`.
    static let pacificoRegular = Rswift.FontResource(fontName: "Pacifico-Regular")
    
    /// `UIFont(name: "Pacifico-Regular", size: ...)`
    static func pacificoRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: pacificoRegular, size: size)
    }
    
    static func validate() throws {
      if R.font.pacificoRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Pacifico-Regular' could not be loaded, is 'Pacifico-Regular.ttf' added to the UIAppFonts array in this targets Info.plist?") }
    }
    
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 7 images.
  struct image {
    /// Image `fillVerticalLeft`.
    static let fillVerticalLeft = Rswift.ImageResource(bundle: R.hostingBundle, name: "fillVerticalLeft")
    /// Image `fillVerticalRight`.
    static let fillVerticalRight = Rswift.ImageResource(bundle: R.hostingBundle, name: "fillVerticalRight")
    /// Image `fillVertical`.
    static let fillVertical = Rswift.ImageResource(bundle: R.hostingBundle, name: "fillVertical")
    /// Image `homeIcon`.
    static let homeIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "homeIcon")
    /// Image `logoAbout`.
    static let logoAbout = Rswift.ImageResource(bundle: R.hostingBundle, name: "logoAbout")
    /// Image `logoApp`.
    static let logoApp = Rswift.ImageResource(bundle: R.hostingBundle, name: "logoApp")
    /// Image `tagIcon`.
    static let tagIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "tagIcon")
    
    /// `UIImage(named: "fillVertical", bundle: ..., traitCollection: ...)`
    static func fillVertical(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.fillVertical, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "fillVerticalLeft", bundle: ..., traitCollection: ...)`
    static func fillVerticalLeft(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.fillVerticalLeft, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "fillVerticalRight", bundle: ..., traitCollection: ...)`
    static func fillVerticalRight(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.fillVerticalRight, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "homeIcon", bundle: ..., traitCollection: ...)`
    static func homeIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.homeIcon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "logoAbout", bundle: ..., traitCollection: ...)`
    static func logoAbout(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.logoAbout, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "logoApp", bundle: ..., traitCollection: ...)`
    static func logoApp(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.logoApp, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "tagIcon", bundle: ..., traitCollection: ...)`
    static func tagIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.tagIcon, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 6 nibs.
  struct nib {
    /// Nib `BannerCollectionViewCell`.
    static let bannerCollectionViewCell = _R.nib._BannerCollectionViewCell()
    /// Nib `BannersView`.
    static let bannersView = _R.nib._BannersView()
    /// Nib `CategoriesView`.
    static let categoriesView = _R.nib._CategoriesView()
    /// Nib `CategoryCollectionViewCell`.
    static let categoryCollectionViewCell = _R.nib._CategoryCollectionViewCell()
    /// Nib `ProductTableViewCell`.
    static let productTableViewCell = _R.nib._ProductTableViewCell()
    /// Nib `ProductsView`.
    static let productsView = _R.nib._ProductsView()
    
    /// `UINib(name: "BannerCollectionViewCell", in: bundle)`
    static func bannerCollectionViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.bannerCollectionViewCell)
    }
    
    /// `UINib(name: "BannersView", in: bundle)`
    static func bannersView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.bannersView)
    }
    
    /// `UINib(name: "CategoriesView", in: bundle)`
    static func categoriesView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.categoriesView)
    }
    
    /// `UINib(name: "CategoryCollectionViewCell", in: bundle)`
    static func categoryCollectionViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.categoryCollectionViewCell)
    }
    
    /// `UINib(name: "ProductTableViewCell", in: bundle)`
    static func productTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.productTableViewCell)
    }
    
    /// `UINib(name: "ProductsView", in: bundle)`
    static func productsView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.productsView)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 3 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `BannerCollectionViewCell`.
    static let bannerCollectionViewCell: Rswift.ReuseIdentifier<BannerCollectionViewCell> = Rswift.ReuseIdentifier(identifier: "BannerCollectionViewCell")
    /// Reuse identifier `CategoryCollectionViewCell`.
    static let categoryCollectionViewCell: Rswift.ReuseIdentifier<CategoryCollectionViewCell> = Rswift.ReuseIdentifier(identifier: "CategoryCollectionViewCell")
    /// Reuse identifier `ProductTableViewCell`.
    static let productTableViewCell: Rswift.ReuseIdentifier<ProductTableViewCell> = Rswift.ReuseIdentifier(identifier: "ProductTableViewCell")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 0 view controllers.
  struct segue {
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 4 storyboards.
  struct storyboard {
    /// Storyboard `About`.
    static let about = _R.storyboard.about()
    /// Storyboard `Home`.
    static let home = _R.storyboard.home()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "About", bundle: ...)`
    static func about(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.about)
    }
    
    /// `UIStoryboard(name: "Home", bundle: ...)`
    static func home(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.home)
    }
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 5 localization tables.
  struct string {
    /// This `R.string.apI` struct is generated, and contains static references to 5 localization keys.
    struct apI {
      /// Value: https://alodjinha.herokuapp.com
      static let baseUrl = Rswift.StringResource(key: "baseUrl", tableName: "API", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: https://alodjinha.herokuapp.com/banner
      static let banners = Rswift.StringResource(key: "banners", tableName: "API", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: https://alodjinha.herokuapp.com/categoria
      static let categories = Rswift.StringResource(key: "categories", tableName: "API", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: https://alodjinha.herokuapp.com/produto/
      static let product = Rswift.StringResource(key: "product", tableName: "API", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: https://alodjinha.herokuapp.com/produto/maisvendidos
      static let productsBestSeller = Rswift.StringResource(key: "productsBestSeller", tableName: "API", bundle: R.hostingBundle, locales: [], comment: nil)
      
      /// Value: https://alodjinha.herokuapp.com
      static func baseUrl(_: Void = ()) -> String {
        return NSLocalizedString("baseUrl", tableName: "API", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: https://alodjinha.herokuapp.com/banner
      static func banners(_: Void = ()) -> String {
        return NSLocalizedString("banners", tableName: "API", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: https://alodjinha.herokuapp.com/categoria
      static func categories(_: Void = ()) -> String {
        return NSLocalizedString("categories", tableName: "API", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: https://alodjinha.herokuapp.com/produto/
      static func product(_: Void = ()) -> String {
        return NSLocalizedString("product", tableName: "API", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: https://alodjinha.herokuapp.com/produto/maisvendidos
      static func productsBestSeller(_: Void = ()) -> String {
        return NSLocalizedString("productsBestSeller", tableName: "API", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    /// This `R.string.messages` struct is generated, and contains static references to 2 localization keys.
    struct messages {
      /// Value: Carregando..
      static let loading = Rswift.StringResource(key: "Loading", tableName: "Messages", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Produto reservado com sucesso
      static let reservedSuccess = Rswift.StringResource(key: "reservedSuccess", tableName: "Messages", bundle: R.hostingBundle, locales: [], comment: nil)
      
      /// Value: Carregando..
      static func loading(_: Void = ()) -> String {
        return NSLocalizedString("Loading", tableName: "Messages", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Produto reservado com sucesso
      static func reservedSuccess(_: Void = ()) -> String {
        return NSLocalizedString("reservedSuccess", tableName: "Messages", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    /// This `R.string.navigationBar` struct is generated, and contains static references to 1 localization keys.
    struct navigationBar {
      /// Value: Sobre
      static let about = Rswift.StringResource(key: "about", tableName: "NavigationBar", bundle: R.hostingBundle, locales: [], comment: nil)
      
      /// Value: Sobre
      static func about(_: Void = ()) -> String {
        return NSLocalizedString("about", tableName: "NavigationBar", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    /// This `R.string.networkError` struct is generated, and contains static references to 4 localization keys.
    struct networkError {
      /// Value: An unexpected error has occurred.
      static let other = Rswift.StringResource(key: "other", tableName: "NetworkError", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: An unexpected error occurred while communicating with the server.
      static let mapping = Rswift.StringResource(key: "mapping", tableName: "NetworkError", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Apparently your connection is weak.
      static let weakConnection = Rswift.StringResource(key: "weakConnection", tableName: "NetworkError", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: You are currently offline.
      static let offline = Rswift.StringResource(key: "offline", tableName: "NetworkError", bundle: R.hostingBundle, locales: [], comment: nil)
      
      /// Value: An unexpected error has occurred.
      static func other(_: Void = ()) -> String {
        return NSLocalizedString("other", tableName: "NetworkError", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: An unexpected error occurred while communicating with the server.
      static func mapping(_: Void = ()) -> String {
        return NSLocalizedString("mapping", tableName: "NetworkError", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Apparently your connection is weak.
      static func weakConnection(_: Void = ()) -> String {
        return NSLocalizedString("weakConnection", tableName: "NetworkError", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: You are currently offline.
      static func offline(_: Void = ()) -> String {
        return NSLocalizedString("offline", tableName: "NetworkError", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    /// This `R.string.tabBarItem` struct is generated, and contains static references to 2 localization keys.
    struct tabBarItem {
      /// Value: Home
      static let home = Rswift.StringResource(key: "home", tableName: "TabBarItem", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Sobre
      static let about = Rswift.StringResource(key: "about", tableName: "TabBarItem", bundle: R.hostingBundle, locales: [], comment: nil)
      
      /// Value: Home
      static func home(_: Void = ()) -> String {
        return NSLocalizedString("home", tableName: "TabBarItem", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Sobre
      static func about(_: Void = ()) -> String {
        return NSLocalizedString("about", tableName: "TabBarItem", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    struct _BannerCollectionViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = BannerCollectionViewCell
      
      let bundle = R.hostingBundle
      let identifier = "BannerCollectionViewCell"
      let name = "BannerCollectionViewCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> BannerCollectionViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? BannerCollectionViewCell
      }
      
      fileprivate init() {}
    }
    
    struct _BannersView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "BannersView"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    struct _CategoriesView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "CategoriesView"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    struct _CategoryCollectionViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = CategoryCollectionViewCell
      
      let bundle = R.hostingBundle
      let identifier = "CategoryCollectionViewCell"
      let name = "CategoryCollectionViewCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> CategoryCollectionViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? CategoryCollectionViewCell
      }
      
      fileprivate init() {}
    }
    
    struct _ProductTableViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = ProductTableViewCell
      
      let bundle = R.hostingBundle
      let identifier = "ProductTableViewCell"
      let name = "ProductTableViewCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> ProductTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? ProductTableViewCell
      }
      
      fileprivate init() {}
    }
    
    struct _ProductsView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "ProductsView"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try about.validate()
      try main.validate()
      try home.validate()
    }
    
    struct about: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "About"
      
      static func validate() throws {
        if UIKit.UIImage(named: "logoAbout") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'logoAbout' is used in storyboard 'About', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    struct home: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = HomeViewController
      
      let bundle = R.hostingBundle
      let homeViewController = StoryboardViewControllerResource<HomeViewController>(identifier: "HomeViewController")
      let name = "Home"
      let productDetailViewController = StoryboardViewControllerResource<ProductViewController>(identifier: "ProductDetailViewController")
      let productsViewController = StoryboardViewControllerResource<ProductsViewController>(identifier: "ProductsViewController")
      
      func homeViewController(_: Void = ()) -> HomeViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: homeViewController)
      }
      
      func productDetailViewController(_: Void = ()) -> ProductViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: productDetailViewController)
      }
      
      func productsViewController(_: Void = ()) -> ProductsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: productsViewController)
      }
      
      static func validate() throws {
        if _R.storyboard.home().homeViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'homeViewController' could not be loaded from storyboard 'Home' as 'HomeViewController'.") }
        if _R.storyboard.home().productDetailViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'productDetailViewController' could not be loaded from storyboard 'Home' as 'ProductViewController'.") }
        if _R.storyboard.home().productsViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'productsViewController' could not be loaded from storyboard 'Home' as 'ProductsViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UITabBarController
      
      let bundle = R.hostingBundle
      let name = "Main"
      
      static func validate() throws {
        if UIKit.UIImage(named: "tagIcon") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'tagIcon' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "homeIcon") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'homeIcon' is used in storyboard 'Main', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
