//
//  ViewAndLayerViewController.swift
//  Learning-iOS

import UIKit

class ViewAndLayerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewA = UIView()
        viewA.frame = CGRect(x: 30, y: 100, width: 100, height: 100)
        viewA.backgroundColor = UIColor.blue

        let viewB = UIView()
        viewB.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        viewB.backgroundColor = UIColor.red

        let viewC = UIView()
        viewC.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        viewC.backgroundColor = UIColor.green

        let layerA = CALayer()
        layerA.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
        layerA.backgroundColor = UIColor.yellow.cgColor

        let layerB = CALayer()
        layerB.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
        layerB.backgroundColor = UIColor.purple.cgColor

        let layerC = CALayer()
        layerC.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
        layerC.backgroundColor = UIColor.brown.cgColor

        view.addSubview(viewA)
        viewA.addSubview(viewB)
        viewB.addSubview(viewC)
        viewA.layer.addSublayer(layerA)
        viewB.layer.addSublayer(layerB)
        viewC.layer.addSublayer(layerC)
    }
}
