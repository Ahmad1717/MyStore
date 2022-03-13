//
//  SigmentControl.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

protocol SegmentControlDelegate: AnyObject {
    func segmentControl(_ segmentControl: SegmentControl, didSelectIndex index: Int)
}

class SegmentControl: UIView {
    private var backgroundSelectionView: UIView = UIView(frame: .zero)
    private var underlineView: UIView = UIView(frame: .zero)
    private var underlineLeadingConstraint: NSLayoutConstraint?
    private var underlineWidthConstraint: NSLayoutConstraint?
    private var underlineHeightConstraint: NSLayoutConstraint?
    private var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    private var selectedIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    private var presentable: Presentable?
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(SegmentControlCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    public private(set) var selectedIndex: Int = 0
    public weak var delegate: SegmentControlDelegate?

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        clipsToBounds = true
        backgroundColor = .clear
        addCollectionView()
        addUnderlineView()
        addBackgroundSelectionView()
        setSelectedIndex(0)
    }
    
    public func styleChanged() {
        reloadData()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        reloadData()
        moveUnderlineToSelected(animated: false)
    }
    
    private func addCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    private func addUnderlineView() {
        addSubview(underlineView)
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineLeadingConstraint = underlineView.leftAnchor.constraint(equalTo: leftAnchor)
        underlineWidthConstraint = underlineView.widthAnchor.constraint(equalToConstant: frame.width / 2)
        underlineHeightConstraint = underlineView.heightAnchor.constraint(equalToConstant: 2)
        guard let underlineLeadingContraint = underlineLeadingConstraint,
              let underlineWidthContraint = underlineWidthConstraint,
              let underlineHeightContraint = underlineHeightConstraint else { return }
        NSLayoutConstraint.activate([
            underlineLeadingContraint,
            underlineWidthContraint,
            underlineHeightContraint,
            underlineView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            underlineView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func addBackgroundSelectionView() {
        insertSubview(backgroundSelectionView, belowSubview: collectionView)
        backgroundSelectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundSelectionView.centerXAnchor.constraint(equalTo: underlineView.centerXAnchor),
            backgroundSelectionView.topAnchor.constraint(equalTo: topAnchor),
            backgroundSelectionView.widthAnchor.constraint(equalTo: underlineView.widthAnchor),
            backgroundSelectionView.bottomAnchor.constraint(equalTo: underlineView.topAnchor)
        ])
    }
    
    func reloadData() {
        guard let presentable = presentable else { return }
        var width: CGFloat = 0
        width = collectionView.bounds.width / CGFloat(presentable.items.count)
        
        flowLayout.itemSize = CGSize(width: width, height: collectionView.bounds.height)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        layoutIfNeeded()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func moveUnderlineToSelected(animated: Bool = true) {
        guard let cell = collectionView.cellForItem(at: selectedIndexPath) as? SegmentControlCollectionViewCell else { return }
        let frame = collectionView.convert(cell.frame, to: self)
        
        underlineWidthConstraint?.constant = frame.width
        underlineLeadingConstraint?.constant = frame.origin.x
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        } else {
            self.layoutIfNeeded()
        }
    }
    
    func selectIndex(indexPath: IndexPath) {
        
        if let item = presentable?.items[indexPath.item], item.disabled { return }
        
        selectedIndexPath = indexPath
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        moveUnderlineToSelected()
        reloadData()
        delegate?.segmentControl(self, didSelectIndex: indexPath.item)
    }
}

extension SegmentControl: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presentable?.items.count ?? 0
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = SegmentControlCollectionViewCell.dequeueReusableCell(in: collectionView, indexPath: indexPath)
        cell.configure(.init(title: presentable?.items[indexPath.item].title))
        cell.setSelected(indexPath == selectedIndexPath)
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        moveUnderlineToSelected(animated: true)
    }
    public func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
        selectIndex(indexPath: indexPath)
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        moveUnderlineToSelected(animated: false)
    }
}

extension SegmentControl {
    public struct UIModel {
        public var title: String?
        public var disabled: Bool
        
        public init(title: String?, disabled: Bool = false) {
            self.title = title
            self.disabled = disabled
        }
    }
    
    public struct Presentable {
        public var items: [UIModel]
        
        public init(items: [SegmentControl.UIModel]) {
            self.items = items
        }
    }
    
    public func configure(_ presentable: Presentable) {
        self.presentable = presentable
        reloadData()
    }
    
    public func setSelectedIndex(_ index: Int) {
        if index < presentable?.items.count ?? 0 {
            self.selectedIndex = index
            selectIndex(indexPath: IndexPath(item: selectedIndex, section: 0))
        }
    }
}
