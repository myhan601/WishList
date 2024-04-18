//
//  WishListViewController.swift
//  WishList
//
//  Created by 한철희 on 4/16/24.
//

import UIKit
import CoreData

class WishListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var wishProducts: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // WishProductCell의 NIB 파일 등록
        let nib = UINib(nibName: "WishProductCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "WishProductCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchWishProducts()
    }
    
    // CoreData에서 위시 리스트 상품을 불러오는 함수
    func fetchWishProducts() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            wishProducts = try context.fetch(fetchRequest)
        } catch {
            print("Fetching Failed.")
        }
        
        tableView.reloadData()
    }
    
    // 테이블 뷰 데이터 소스 메소드 구현
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WishProductCell", for: indexPath) as? WishProductCell else {
            fatalError("The dequeued cell is not an instance of WishProductCell.")
        }
        
        let wishProduct = wishProducts[indexPath.row]
        
        let productToDisplay = WishProduct(id: String(wishProduct.id), title: wishProduct.title ?? "", price: Int(wishProduct.price))

        cell.configure(with: productToDisplay)

        
        return cell
    }
    
    // 선택한 상품 삭제 기능
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteWishProduct(at: indexPath)
        }
    }
    
    // CoreData에서 선택한 상품 삭제
    func deleteWishProduct(at indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(wishProducts[indexPath.row])
        wishProducts.remove(at: indexPath.row)
        
        do {
            try context.save()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } catch {
            print("Deleting Failed.")
        }
    }
}
