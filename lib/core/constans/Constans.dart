import 'package:cloud_firestore/cloud_firestore.dart';

class AppConst {
  static const String isOnBoarding = "isOnboarding";
  static const String Language = "lang";
  static const String userId = "ID";
  static const String userName = "USERNAME";
  static const String userPass = "PASSWORD";
  static const String userSubject = "SUBJECT";
  static const String userIsAdmin = "ISADMID";
  static const String userPhone = "PHONE";
  static const String isworker = "isWorker";
  static const String serverKey = "AIzaSyB72ZlUGswn-5DwS1RCFXCwZk1To23AE-A";
  static const String cairoFont = "Cairo";
  static const String phone = "Phone";
  static const String email = "Email";
  static const String worker = "Worker";
  static const String longText = "longText";
  static const String password = "Password";
  static const String workImagesPath = "images/work/";
  static const String defultImageUrl =
      "https://firebasestorage.googleapis.com/v0/b/myfirstfirebaseapp-7355a.appspot.com/o/images%2Fdefults%2Fperson2.jpg?alt=media&token=d20af99c-bdb3-4932-a4d8-13d8506d1f52";
  // databas
  static const String favoritTable = "favorit";
  static const String favoritWorkerId = "workerId";
  static const String favoritId = "Id";
  static const String AllWorkers = "AllWorkers";
  static const String AllUsers = "AllUsers";
  static const String notificationsvalid = "notify";
}

class FirebaseConst {
  static var userColumn = FirebaseFirestore.instance.collection(users);
  static var commintsColumn = FirebaseFirestore.instance.collection(rating);
  static var bookingColumn = FirebaseFirestore.instance.collection(booking);
  static var moneyColumn =
      FirebaseFirestore.instance.collection(moneyCollection);
  static const String agreeBooking = "yes";
  static const String disagreeBooking = "no";
  static const String workerImages = "myImages";
  static const String onLine = "online";
  static const String offLine = "ofline";

  //colections
  static const String users = "Users";
  static const String rating = "Ratings";
  static const String booking = "Booking";
  static const String notification = "Notifications";
  static const String moneyCollection = "MoneyAndTime";

  //rating collection
  static const String ratingStars = "Stars";
  static const String ratingWorkerId = "workerId";
  static const String ratingSenderId = "SinderId";
  static const String ratingSenderName = "SenderName";
  static const String ratingText = "Text";
  static const String ratingType = "Type";
  static const String ratingWait = "wait";
  static const String ratingYes = "Yes";

  //money colection
  static const String moneyWorkerId = "WorkerId";
  static const String moneyWorkerName = "WorkerName";
  static const String moneyUserId = "UserId";
  static const String moneyTime = "Date";
  static const String moneyWorkTime = "workTime";
  static const String moneyText = "Text";
  static const String moneyType = "Type";
  static const String moneyRating = "Rating";
  static const String moneyRead = "Read";
  static const String moneyCommint = "Commint";

  static const String moneyId = "id";
  //money colections types
  static const String moneyRatingTypeWait = "wait";
  static const String moneyRatingTypeYes = "yes";
  static const String moneyTypeWait = "wait";
  static const String moneyTypeYes = "yes";
  static const String moneyTypeNo = "no";

  //user coloection
  static const String userName = "Username";
  static const String userDis = "Disc";
  static const String userCanEnter = "canEnter";
  static const String userAdmin = "isAdmin";
  static const String userIsWorker = "isWorker";
  static const String userPay = "pay";
  static const String userRating = "Rating";
  static const String userWorkType = "WorkType";
  static const String userState = "State";
  static const String userLat = "lat";
  static const String userLong = "long";
  static const String userProfileImage = "ProfileImage";
  static const String userToken = "Token";
  static const String userId = "Id";
  static const String userIsOnline = "isonline";
  static const String userPhone = "Phone";
  static const String userVerfiyCode = "VerifyCode";
  static const String defultImage = "Defult";
  static const String normalUser = "NormalUser";
  static const int defultRating = 5;

  //notification collection
  static const String notifyReciverId = "reciverId";
  static const String notifyTime = "Time";
  static const String notifyTitle = "Title";
  static const String notifyText = "Text";
  static const String notifyId = "Id";

  // booking collection
  static const String bookingSenderId = "bookingSenderId";
  static const String bookingWorkerId = "bookingReciverId";
  static const String bookingService = "bookingServices";
  static const String bookingTime = "bookingTime";
  static const String bookingType = "bookingType";
  static const String bookingText = "bookingText";
  static const String bookingWait = "wait";
  static const String bookingLocation = "location";
  static const String bookingRead = "readbooking";
  static const String bookingId = "id";
  static const String bookingWorkerName = "WorkerName";
  static const String bookingOk = "ok";
  static const String bookingNo = "no";
  static const String bookingdistanceBetween = "distanceBetween";

  //Nested collection image
  static const String imageId = "id";
  static const String imageUrl = "url";
  static const String imageTime = "Date";
}

class UserConst {
  static const String userName = "name";
  static const String userId = "id";
  static const String userIsworker = "isworker";
}
