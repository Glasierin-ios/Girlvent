//
//  CategoriesListVc.swift
//  Girlvent
//
//  Created by Glasier Inc. on 23/01/20.
//  Copyright © 2020 Glasier Inc. All rights reserved.
//

import UIKit

class CategoriesListVc: UIViewController {

      
    @IBOutlet weak var categorieslistTable: UICollectionView!
    @IBOutlet weak var Backbutton: UIButton!
    
    @IBOutlet var lblTitle: UILabel!
    
    
    
    var  categoriesListArray = [GetCategoriesListData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = GLocalizedString(key: "menu_Categories")
                GetCategoriesListAPI()

    }
    

    //MARK:- == FUNCTION FOR GET Categories POST API ==
                func GetCategoriesListAPI(){
                    //let TokenId = UserDefaults.value(forKey: "TokenId") as! String
                    
                    
                   let param = [:] as [String : AnyObject]
                    
                    print(param)
                    
                    APIHelper.shared.GetCategoriesListAPIcall(parameter: param) { (success, result) in
                        
                        if(result.data != nil){
                            if(success){
                             
                               self.categoriesListArray = result.data
                                self.categorieslistTable.reloadData()
                            }
                        } else{
                            
                         
                            print("Not Success")
                        }
                    }
           }
    @IBAction func BackButtonClick(_ sender: Any) {
          
        self.navigationController?.popViewController(animated: true)
    }
}
extension CategoriesListVc:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.categoriesListArray.count
}

// make a cell for each cell index path
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    // get a reference to our storyboard cell
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCellpuch", for: indexPath as IndexPath) as! CategoriesCell

    cell.CategoriesNameLable.text = self.categoriesListArray[indexPath.row].name

    
    return cell
}
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CategoriesPostListVC") as! CategoriesPostListVC
        therapiescall.categoriesid = self.categoriesListArray[indexPath.row].id
        therapiescall.categoriName = self.categoriesListArray[indexPath.row].name
                       self.navigationController?.pushViewController(therapiescall, animated: true)
        
    }

// MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 3

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
