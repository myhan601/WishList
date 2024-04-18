//
//  WishProductCell.swift
//  WishList
//
//  Created by 한철희 on 4/17/24.
//

import UIKit

struct WishProduct {
    let id: String
    let title: String
    let price: Int
}

class WishProductCell: UITableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // 가격을 1000단위로 콤마 처리하는 메소드
    private func formatPrice(_ price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal // 숫자 스타일을 소수점 형태로 설정
        let formattedPrice = numberFormatter.string(from: NSNumber(value: price)) ?? "\(price)"
        return "\(formattedPrice)원"
    }
    
    // 제품 정보를 셀에 설정하는 메소드
    func configure(with product: WishProduct) {
        idLabel.text = product.id
        titleLabel.text = product.title
        priceLabel.text = formatPrice(product.price)
    }
}


