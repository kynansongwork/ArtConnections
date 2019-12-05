//
//  S3Service.swift
//  ArtConnections
//
//  Created by Kynan Song on 04/12/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import AWSS3

class S3Service: NSObject {
    
    let S3Bucket = "artconnections"
    var profileImage = UIImage(named: "placeHolderImage")

    //configure authenitcation
    let userPool: UserPool
    let region = AWSRegionType.USEast2
    let credentialsProvider: AWSCognitoCredentialsProvider
    let configuration: AWSServiceConfiguration
    
    override init() {
        self.userPool = UserPool()
        let cognitoPoolID = userPool.poolID
        credentialsProvider = AWSCognitoCredentialsProvider(regionType: region, identityPoolId: cognitoPoolID)
        configuration = AWSServiceConfiguration(region: region, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        super.init()
    }
    
    func uploadImage(imageName: String) {
        let ext = "png"
        guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: ext) else { return }
        
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        let transferManager = AWSS3TransferManager.default()

        uploadRequest?.body = imageURL
        uploadRequest?.key = ProcessInfo.processInfo.globallyUniqueString + "." + ext
        uploadRequest?.bucket = S3Bucket
        uploadRequest?.contentType = "image/" + ext
        
        if let request = uploadRequest {
            transferManager.upload(request).continueWith(block: { (task) -> AnyObject? in
                if let error = task.error {
                    print("Upload failed ❌ (\(error))")
                }
                
                if task.result != nil {
                    let s3URL = URL(string: "http://s3.amazonaws.com/\(self.S3Bucket)/\(request.key)")!
                    print("Uploaded image to: \(s3URL)")
                    do {
                        let image = try UIImage(data: Data(contentsOf: s3URL))
                        self.profileImage = image
                    } catch {
                        print(error)
                    }
                    
                    
                } else {
                    print("No image present")
                }
                return nil
            })
        }
    }
}

//https://www.codementor.io/tips/5748713276/how-to-upload-images-to-aws-s3-in-swift
//https://github.com/awslabs/aws-sdk-ios-samples/tree/master/S3TransferUtility-Sample/Swift/S3BackgroundTransferSampleSwift
//https://stackoverflow.com/questions/56018179/how-to-upload-to-s3-bucket-taking-a-photo-with-the-ios-camera
//https://medium.com/@alexpaterson/uploading-images-to-aws-s3-in-swift-with-a-node-backend-655940a053b3g

