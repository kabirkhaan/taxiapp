//
//  TaxiTableViewCell.swift
//  TaxiApp
//
//  Created by Kabir Khan on 06.12.20.
//

import Foundation
import UIKit

final class TaxiTableViewCell: UITableViewCell {

    func configure(with viewData: TaxiViewData) {
        textLabel?.text = viewData.text
        imageView?.image = viewData.image
    }

}
