//
//  ProductsViewController.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

class ProductsViewController: BaseViewController {

    override var shouldHideNavigationBar: Bool { false }
    
    // MARK: - Properties
    var output: ProductsInteractorInput?
    var router: ProductsRouterProtocol?
    
    private var products = [ProductsUIModel.ProductUIModel]()
    
    @IBOutlet private weak var segmentControl: SegmentControl?
    @IBOutlet private weak var collectionView: UICollectionView?
    @IBOutlet private weak var searchView: UIView?
    @IBOutlet private weak var searchTextField: UITextField?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

}

private extension ProductsViewController {
    
    // MARK: - Configure View
    func configureView() {
        configureCollectionView()
        configureNavigationBar()
        segmentControl?.delegate = self
        searchTextField?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        output?.initView()
    }
    
    func configureNavigationBar() {
        setLeftBarItems()
        setRightBarItems()
    }
    
    func setLeftBarItems() {
        let iconBarButton = UIBarButtonItem(image: UIImage(named: "BurgerMenu"), style: .done, target: self, action: #selector(didTapBurgerIcon))
        let titleBarButton = UIBarButtonItem(title: "My Store", style: .done, target: self, action: #selector(didTapTitle))
        
        navigationItem.setLeftBarButtonItems([iconBarButton, titleBarButton], animated: false)
    }
    
    func setRightBarItems() {
        let searchIconBarButton = UIBarButtonItem(image: UIImage(named: "Search"), style: .done, target: self, action: #selector(didTapSearch))
        let bagIconBarButton = UIBarButtonItem(image: UIImage(named: "Store"), style: .done, target: self, action: #selector(didTapBag))
        
        navigationItem.setRightBarButtonItems([searchIconBarButton, bagIconBarButton], animated: false)
    }
    
    func configureCollectionView() {
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.registerNib(ProductCollectionViewCell.self)
        
        let layout = UICollectionViewFlowLayout()
             layout.scrollDirection = .vertical
             layout.minimumLineSpacing = 8
             layout.minimumInteritemSpacing = 6
        collectionView?.setCollectionViewLayout(layout, animated: true)
    }
    
    @objc func didTapBurgerIcon() {
        
    }
    
    @objc func didTapTitle() {
        
    }
    
    @objc func didTapBag() {
        
    }
    
    @objc func didTapSearch() {
        searchView?.isHidden.toggle()
    }
    
    @objc func editingChanged() {
        
        output?.search(for: searchTextField?.text ?? "")
    }
}

extension ProductsViewController: SegmentControlDelegate {
    func segmentControl(_ segmentControl: SegmentControl, didSelectIndex index: Int) {
        output?.switchTo(index: index)
    }
}

// MARK: - UICollectionView DataSource
extension ProductsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentItem = products[indexPath.row]
        
        let cell = ProductCollectionViewCell.dequeueReusableCell(in: collectionView, indexPath: indexPath)
        cell.presentable = .init(productName: currentItem.name,
                                 productPrice: currentItem.price,
                                 productImage: currentItem.image,
                                 productDescription: currentItem.description)
        
        return cell
    }
}

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize.zero }
        let widthPerItem = collectionView.frame.width / 2 - layout.minimumInteritemSpacing
        
        return CGSize(width: widthPerItem - 2, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 4.0, bottom: 1.0, right: 2.0)
    }
}

// MARK: - The data that the Presenter sends
extension ProductsViewController: ProductsPresenterOutput {
    func initView(model: ProductsUIModel ) {
        segmentControl?.configure(model.categories)
        self.products = model.products
    }
    
    func reloadView(model: ProductsUIModel ) {
        self.products = model.products
        collectionView?.reloadData()
    }
}
