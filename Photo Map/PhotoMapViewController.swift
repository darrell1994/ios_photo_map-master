//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Nicholas Aiwazian on 10/15/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var cameraContainerView: UIView!
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        cameraContainerView.clipsToBounds = true
        cameraContainerView.layer.cornerRadius = cameraContainerView.frame.height/2
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "onTappingCamera:")
        cameraContainerView.userInteractionEnabled = true
        cameraContainerView.addGestureRecognizer(tapGesture)
        
        let sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667),
            MKCoordinateSpanMake(0.1, 0.1))
        mapView.setRegion(sfRegion, animated: false)
    }

    func onTappingCamera(gesture: UITapGestureRecognizer) {
        print("Camera tapped")
//        let cameraView = gesture.view!
//        let frame = view.frame
//        
//        UIView.animateWithDuration(0.2, delay: 0, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.CurveEaseIn], animations: { () -> Void in
//            cameraView.transform = CGAffineTransformMakeScale(1.2, 1.2)
//            }, completion: { (Bool) -> Void in
////                cameraView.frame = frame
////                cameraView.layer.cornerRadius = cameraView.frame.height/2
//            }
//)
        
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            vc.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    var selectedImage: UIImage?
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            selectedImage = editedImage
            dismissViewControllerAnimated(true, completion: nil)
            self.performSegueWithIdentifier("tagSegue", sender: nil)
    }
}
