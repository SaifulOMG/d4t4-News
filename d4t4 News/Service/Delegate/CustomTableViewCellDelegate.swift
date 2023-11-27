//
//  CustomTableViewCellDelegate.swift
//  d4t4 News
//
//  Created by Briteyellow on 26/11/2023.
//

import Foundation

//code to handle button press on tableview
protocol CustomTableViewCellDelegate: AnyObject {
    func didTapSpeechButton(withText text: String)
    func didTapViewButton(withURL url: String)
}
