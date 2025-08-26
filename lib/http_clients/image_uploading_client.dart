
import 'package:cloudinary_sdk/cloudinary_sdk.dart';


class ImageUploadingClient{
  late Cloudinary cloudinary;

  ImageUploadingClient(){
cloudinary = Cloudinary.full(
    apiKey:"831213957632568",
    apiSecret:"qqBK873V87Q8h-Teb2CgRggmE0c",
    cloudName:"dh1h9qucw");
  }

Future<CloudinaryResponse> uploadImage(String imagePath){
return cloudinary.uploadResource(
    CloudinaryUploadResource(
        filePath: imagePath,
        resourceType: CloudinaryResourceType.image));
}

}