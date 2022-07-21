// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shop_app/Views/HomeScreen/home_screen.dart';
// import '../ViewModels/Block/Cubit.dart';
// import '../ViewModels/Block/States.dart';
// import '../ViewModels/Local/CacheHelper.dart';
// import '../Views/CategoriesScreen/CategoriesScreen.dart';
// import '../Views/UserScreens/LoginScreen.dart';
// import '../Views/UserScreens/account_info_screen.dart';
// import '../Views/WishlistScreen/favouriteScreen.dart';
// import '../ViewModels/Components.dart';
// import '../Views/SearchScreen/searchScreen.dart';
// import '../ViewModels/constants.dart';

// class Layout extends StatefulWidget {
//   @override
//   State<Layout> createState() => _ShopLayoutState();
// }

// class _ShopLayoutState extends State<Layout> {
//   int currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home:BlocProvider<ShopCubit>(
//           create: (context) {
//             return ShopCubit();
//           },
//           child: BlocConsumer<ShopCubit, ShopStates>(
//             builder: (BuildContext context, Object? state) {
//               List<Widget> pages = [
//                 HomeScreen(),
//                 CategoriesScreen(),
//                 FavouriteScreen(),
//                 // ProfileScreen()
//                 AccountInfoScreen(),
//                 // Address(),
//                 // RestPasswordScreen()
//                 // ProductsScreen(),
//               ];
//               return Scaffold(
//                 resizeToAvoidBottomInset: false,
//                 appBar: AppBar(
//                   backgroundColor: defaultColor,
//                   title: const Text("ShopApp"),
//                   actions: [
//                     IconButton(
//                         onPressed: () {
//                         //  navigateTo(context, SearchScreen());
//                         },
//                         icon: const Icon(Icons.search))
//                   ],
//                 ),
//                 body: SafeArea(child: pages[currentIndex]),
//                 bottomNavigationBar: BottomNavigationBar(
//                   selectedItemColor: defaultColor,
//                   type: BottomNavigationBarType.fixed,
//                   currentIndex: currentIndex,
//                   items: const [
//                     BottomNavigationBarItem(
//                         icon: Icon(Icons.home), label: "Home"),
//                     BottomNavigationBarItem(
//                         icon: Icon(Icons.apps_sharp), label: "Categories"),
//                     BottomNavigationBarItem(
//                         icon: Icon(Icons.favorite), label: "Favourites"),
//                     BottomNavigationBarItem(
//                         // icon: Icon(Icons.settings), label: "Setting"),
//                         icon: Icon(Icons.person), label: "Profile"),
//                   ],
//                   onTap: (index) {
//                     setState(() {
//                       currentIndex = index;
//                       print(currentIndex);
//                     });
//                   },
//                 ),
//               );
//             },
//             listener: (context, states) {},
//           )),
//     );
//   }

//   TextButton buildTextButton(BuildContext context) {
//     return TextButton(
//       onPressed: () {
//         CacheHelper.removeKey(key: "token").then((value) => buildShopToast(
//                 message: "Logout done Successfully", state: LoginState.success)
//             .then((value) => navigateAndReplace(context, LoginScreen())));
//       },
//       child: const Text("LogOut"),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Service/fireStore_Order.dart';
import 'package:shop_app/Service/fireStore_WishList.dart';

import '../Service/fireStore_Cart.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({ Key? key }) : super(key: key);

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  
  int  currentIndex = 0;

  @override
  Widget build(BuildContext context) {
   String? userId,state,productId;
   List<String> productIds=[];
   TextEditingController prod1 = TextEditingController();
   TextEditingController Prod2 = TextEditingController();
   


   List<Map<String, dynamic>> categories=
  [
  {
  "categoryId": 1,
  "name": "women-dresses",
  "image": "https://i.pinimg.com/236x/c0/31/0f/c0310fd2250a904e3af5682ceb7992f4.jpg"
  },
  {
  "categoryId": 2,
  "name": "women-jewellery",
  "image": "https://medias.utsavfashion.com/media/catalog/product/cache/1/image/500x/040ec09b1e35df139433887a97daa66f/k/u/kundan-necklace-set-v1-jmy866.jpg"
  },
  {
  "categoryId": 3,
  "name": "women-watches",
  "image": "https://ae01.alicdn.com/kf/HTB1CpnvaUD1gK0jSZFGq6zd3FXaH/Women-Watches-Women-Fashion-Watch-Luxury-Diamond-Women-s-Gold-Wrist-Watch-Ladies-Watch-Women-Gifts.jpg_Q90.jpg_.webp"
  },
  {
  "categoryId": 4,
  "name": "women-bags",
  "image": "https://image.made-in-china.com/202f0j00UZtYDPfGVhkO/2021-Fashion-Women-Tote-Bag-Women-Handbag-Ladies-PU-Leather-Shoulder-Luxury-Bags-Women-Handbags.jpg"
  },
  {
  "categoryId": 5,
  "name": "sunglasses",
  "image": "https://assets.aspinaloflondon.com/images/square-large/1089423-006-2424-253100003.jpg"
  },
  {
  "categoryId": 6,
  "name": "men-shirts",
  "image": "https://na3em.cc/wp-content/uploads/2018/11/5297-4.jpg"},
  {
  "categoryId": 7,
        "name": "men-watches",
        "image": "https://reviewmefirst.com/storage/luxury-mens-watches/screen-shot-2020-12-06-at-10-32-58-pm-copy.webp"
    },
    {
    "categoryId": 8,
        "name": "irons",
        "image": "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F37%2F2022%2F04%2F19%2FBHG_BLACKDECKER-IR1010-Light-_N-Easy-Compact-Steam-Iron_3-2000.jpg"
    },
    {
        "categoryId": 9,
        "name": "fans",
        "image": "https://www.thespruce.com/thmb/SPImRXYRJ3IfRksHiCih-q01qoI=/1500x1000/filters:fill(auto,1)/Web_1500-SPR_Group_RM_02-595106cea66b4633bb1962295055885c.jpg"
    }

  ];
List<Map<String, dynamic>> products=
  
    [
        {
            "productId": 1,
            "name": "Multicolored Dress",
            "description": "This classy dress for women gives you a gorgeous look on everyday wear and specially for semi-casual wears.",
            "price": 79.00,
            "oldPrice": 86,
            "discount": 10,
            "categoryName": "women-dresses",
            "image": "https://img.ltwebstatic.com/images3_pi/2021/05/08/16204363341cfb2d8fff0fa68d2cdd70bb8b7e91ac.webp",
            "prodImages": [
                "https://img.ltwebstatic.com/images3_pi/2021/05/08/16204363382e42ede215c732d55872d197135e87c5.webp",
                "https://img.ltwebstatic.com/images3_pi/2021/05/08/1620436350ce649f1b780ce983d37f76b65d39fb3d.webp"
            ],
            "noItemsInStock": 50
        }
        ,
        {
            "productId": 2,
            "name": "summer Dress",
            "description": "Wear this stunning bohemian and feminine Maxi Dress in summer with cute sandals and a fedora or layer her with a jacket and boots during the cooler seasons. ",
            "price": 89.00,
            "oldPrice": 103.5,
            "discount": 15,
            "categoryName": "women-dresses",
            "image": "https://ae01.alicdn.com/kf/H6d266d29aa89407398b6af5088e1d6f3R/-.jpg_Q90.jpg_.webp",
            "prodImages": [
                "https://ae01.alicdn.com/kf/Hd9b457dc879f4c11849c7a8b4daafa9eY/-.jpg_Q90.jpg_.webp",
                "https://ae01.alicdn.com/kf/H58a52c16885146a28667f5141afbae016/-.jpg_Q90.jpg_.webp"
            ],
            "noItemsInStock": 40
        }
        ,
        {
            "productId": 3,
            "name": "Ladies Dress",
            "description": "Women Plus Size Sexy Lace Up Slim Dress with Belt Evening Party Cocktail",
            "price": 99.00,
            "oldPrice": 119,
            "discount": 20,
            "categoryName": "women-dresses",
            "image": "https://ae01.alicdn.com/kf/HTB10dVjX0knBKNjSZKPq6x6OFXaY/Joineles-Plus-Size-Navy-Blue-Color-Women-Summer-Dress-V-Neck-Short-Sleeves-Belts-Retro-Dress.jpg",
            "prodImages": [
                "https://i5.walmartimages.com/asr/1a94519e-eb7c-432c-8bb2-29fcc7e7060d_1.3643bf1fd907fff3b0cdd3be6384eefa.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/4b7c2c66-371e-4af6-b6f6-38f11ea0d067_1.b937832891d98a95945e80637fc66980.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 25
        }
        ,
        {
            "productId": 4,
            "name": "KOH KOH Long Bridesmaid Formal Short",
            "description": "Sleeve V-Neck Full Floor Length Flowy Cocktail Summer Evening Wedding Guest Party Tall Maxi Dress Gown For Women Gray Grey.",
            "price": 90.00,
            "oldPrice": 102,
            "discount": 13,
            "categoryName": "women-dresses",
            "image": "https://i5.walmartimages.com/asr/7b9dbdae-873e-4bac-aea0-dbb634407869.bc222b9d56ba6702f9cdb10dad88c8d9.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/3a01f25e-12c0-4b31-ae55-b2b0d66790be.056b059935dd94fe201f07562b9487ff.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/f1a93796-a541-4d25-86da-325ff8b1b40f.67951668b0585fb2c71e76abc252b22e.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/f1a93796-a541-4d25-86da-325ff8b1b40f.67951668b0585fb2c71e76abc252b22e.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 20
        }
        ,
        {
            "productId": 5,
            "name": "Simple Dress",
            "description": " JASAMBAC Women's V Neck Lace Vintage Formal Wedding Guest Cocktail Party Dress Lace dress.",
            "price": 30.00,
            "oldPrice": 32,
            "discount": 6,
            "categoryName": "women-dresses",
            "image": "https://i5.walmartimages.com/asr/647ad225-045a-4bc1-a0ad-ac16a1943028.babe400be3eba844112fb7927028baf8.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/c8d1fcff-3b03-4b21-b510-e657e3273d3a.5f11fa34001796989481920f028f4af4.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/59ea5aa9-3b4c-4ab2-a149-9bd31ff35cb2.1e8ba24fd96cbb5765b07b5ccc732896.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/79d9c81c-05fc-4900-a121-aaddc1e7e266.7713f546df40e95c4956b12fa76f8952.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 15
        }
        ,
        {
            "productId": 6,
            "name": "Vintage Party Dress ",
            "description": "Dokotoo Womens Sky Blue Dress Embroidery Floral V Neck Tunic Party Dress",
            "price": 31.00,
            "oldPrice": 32.5,
            "discount": 5,
            "categoryName": "women-dresses",
            "image": "https://i5.walmartimages.com/asr/41aeba1a-7f20-4d0d-8342-146fb8ffa2ba.dfcbddc8d4fa6a6289b0d46dab376306.png?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/75c525ef-167c-4e01-bce6-ac264e643912.d00ab586fe09d595416ec30be9c84048.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/a81417f7-d68b-4d0b-b2e4-205acee5b475.494206cf7a54d821188bbf053a0a8f1e.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 12
        }
        ,
        {
            "productId": 7,
            "name": "Simple Black Dress",
            "description": "Aiyino Women's Long Sleeve Polka Dot Casual Dress Pleated Loose Flowy Midi Dress With Pocket",
            "price": 27.00,
            "oldPrice": 125.5,
            "discount": 8,
            "categoryName": "women-dresses",
            "image": "https://i5.walmartimages.com/asr/ba79f186-2a9d-4eca-b933-0e30acc5b333.69480de367d45b717c43e6c8a2468a86.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/c59f88fa-15e3-46e1-8dbc-6ea63a0b3aea.6588285c9402a57c3cc1c484471eeaa5.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/10dc5031-9326-4858-9e62-c5788e089010.1cc2911de33818da0f434a57dd6b480f.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 17
        }
        ,
        {
            "productId": 8,
            "name": "Women's summer Dress",
            "description": "Aiyino Women's Print Casual Flowy Short Sleeve Midi Dress with Belt",
            "price": 40.00,
            "oldPrice": 42,
            "discount": 5,
            "categoryName": "women-dresses",
            "image": "https://i5.walmartimages.com/asr/a0da7610-0223-499b-be99-069090daa850.0615137c752fe05902a989a1e3d92ab4.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/e481c635-92be-4b54-8da1-58cfaf8ec2e5.040e0af31e2dbb11c71776c1218fb33b.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/7c1a0efa-3231-40c7-8fef-194d235769a3.fd366e17e989e99b5abc585fa31ba180.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/0b6e20cc-39a0-4f01-a468-2afd42fa6262.730ad4ae471e15510dfc319f0f623fd3.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 13
        }
        ,
        {
            "productId": 9,
            "name": "Simple Ladie's Dress",
            "description": "SHIBEVER Women Sleeveless Dress Summer Floral Bohemian V Neck Button Down Flowy Dresses",
            "price": 50.00,
            "oldPrice": 52,
            "discount": 3,
            "categoryName": "women-dresses",
            "image": "https://i5.walmartimages.com/asr/4cb17762-4558-4137-a02c-ab865e18469d.f9f41e458debba66d31692b9fe2de5c8.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/f9403fda-3416-4e96-a9f9-c33c7d295373.6be1877a341e5510812103d787124864.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/a9aa8575-d8b8-4405-8b5b-8a0817ab52b6.eab5c333144a17e4070fe47ee10f1906.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/fb473df5-6924-4a96-9348-8a384cb586ab.03518f1f186edb6694ca0b71de901794.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 42
        }
        ,
        {
            "productId": 10,
            "name": "GLESTORE Women's Dress ",
            "description": "Maternity Dress Summer Sleeveless Round Neck Black M",
            "price": 70.00,
            "oldPrice": 91,
            "discount": 30,
            "categoryName": "women-dresses",
            "image": "https://i5.walmartimages.com/asr/b14a8bce-b493-4c76-bf84-04b81fffe5df.22873f9ef6d80a16dcc0199bd9e966cb.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/cc501037-e3c2-41c1-9207-fccab5a3aa88.2d01e7de7af6f1fdf78956ce8ce4cc0a.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF", "https://i5.walmartimages.com/asr/a9aa8575-d8b8-4405-8b5b-8a0817ab52b6.eab5c333144a17e4070fe47ee10f1906.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/dd496902-3fff-436e-b636-ac170a45d51e.e71240985b74bbb2a21e8740400e997b.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 46
        }

    ,


    
        {
            "productId": 11,
            "name": "Silver Ring Women",
            "description": "TANGPOET Snake Rings for Women 925 Sterling Silver Thumb Ring Adjustable 7-9 Snake jewelry Gifts",
            "price": 70.00,
            "oldPrice": 79,
            "discount": 13,
            "categoryName": "women-jewellery",
            "image": "https://i5.walmartimages.com/asr/4456e079-8983-4681-b8f9-82d7b523a248.22e37ea455fdab113e717c69f5b1bd79.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/f2ea0b61-8086-4af3-b97a-cc8921621fad.ebede926387697c23b76ba7e1323f6ef.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/08b5262c-32a5-4376-aeed-0bc280256ab1.3b0bd5cbb7d5f8364ebeef1e1427dec6.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/f4fc5754-a29d-4f8b-aaab-57be719e733e.6505a1b1237ba207318073c59513ff9b.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 34
        }
        ,
        {
            "productId": 12,
            "name": "Rose Ring",
            "description": "Brand: The Greetings Flower , GoldenSize: Adjustable",
            "price": 100.00,
            "oldPrice": 102,
            "discount": 3,
            "categoryName": "women-jewellery",
            "image": "https://i5.walmartimages.com/asr/16758959-4d13-47a7-ace0-f2e002b67227.92ac2d31d69adc3907747fb98c4d4902.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/7541daf8-f3fc-410c-a592-102506a2e56f.6bfabf84d49d9ae2a5a083e634c1af52.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/58739da6-883a-43ee-8931-d75718d4922d.854ac370d50b2615143f24735e23303c.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 41

        }
        ,
        {
            "productId": 13,
            "name": "Cute Leaf Full Finger Cocktail Ring",
            "description": "U7 Women Gold Plated Cute Leaf Full Finger Cocktail Ring Adjustable Bride Ring with Cubic Zirconia",
            "price": 30.00,
            "oldPrice": 35,
            "discount": 8,
            "categoryName": "women-jewellery",
            "image": "https://i5.walmartimages.com/asr/2052a8ba-74d2-40ad-bd08-9bcd30ec0d4c.592d6beefdbf9e3216135ec36fc07708.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/42b968a0-6745-47a3-be85-74b66587076d.214ccfac68cfb8c6aa512033f3da8c97.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/162102d5-7781-41a1-a27c-a4f68db3afa3.0a8667de00b1bd42ef1b3147f82a0e34.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 57
        }
        ,
        {
            "productId": 14,
            "name": "Elegant Female Pearl Earrings",
            "description": "Elegant Female Pearl Earrings Set Zircon Pearl Earings Women Party Accessories 9 Pairs/Set",
            "oldPrice": 85.2,
            "price": 79.00,
            "discount": 12,
            "categoryName": "women-jewellery",
            "image": "https://i5.walmartimages.com/asr/f1f1abef-e366-4435-87c2-97db8f312489_1.620a229065ca1e1d2ae3398e2357b773.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/b525d15d-49fe-4842-82e5-df632375eda0_1.54dd8c475227c81549e5c7a47828bb6d.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/58a9c09b-7df6-4b84-9a76-0abb99beff57_1.8e789b9ed9f243c796ccb8ae209c8bb9.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 52
        }
        ,
        {
            "productId": 15,
            "name": "Heart Drop Dangle Earrings",
            "description": "Shop LC Heart Drop Dangle Earrings Jewelry Gifts Rose Gold over 925 Sterling Silver",
            "oldPrice": 119,
            "price": 45.00,
            "discount": 17.75,
            "categoryName": "women-jewellery",
            "image": "https://i5.walmartimages.com/asr/5494806b-6414-485b-bf51-3a0107730e01.f98a1d60e688966e5ee248b55f6670e3.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/59d6be6e-a1da-429a-8f41-579d78e5981a.cf7eda86c8febc8b0f9d39235a7f2c3a.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/fbf8ca87-df08-43f7-9cff-b54466608347.b15c3fe5eb635d69b49d4016b6d33a79.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/dc930892-95d4-49b9-bd59-c6f43edf0ec2.6bb09f516e254788a866cbf0819640d7.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/cb58c99f-9a21-4f94-8c5c-a797c309072f.44686fc26079f983d57fc5db5ccbbb25.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 41
        }
    ,

    
        {
            "productId": 16,
            "name": "YAMAY SW022 Round Smart Watch for Android Samsung iPhone",
            "description": "Fitness Tracker with Heart Rate Monitor Steps Sleep Tracker Customized Watch Face IP68 Waterproof Smartwatch for Women Pink",
            "oldPrice": 37,
            "price": 35,
            "discount": 3.23,
            "categoryName": "",
            "image": "https://i5.walmartimages.com/asr/1955fe63-6904-47f1-983b-3cb4aab08a2f.9582355e0bc21b2d660da05f086bde7b.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/b92cae42-ec9a-4d72-8231-d04193b2a8ac.c44040e997cd782b62f58eeb02146e75.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/f99ba765-7874-4771-a761-2e17373afa67.4c055b73c6ca5f644234ad2b684869d5.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/004f85b3-e9bc-4fec-b91e-de4dbfe3f024.299e5e2af383c70104095c1f14ecf0c8.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            ],
            "noItemsInStock": 41
        },
        {
            "productId": 17,
            "name": "Kendall + Kylie Watch",
            "description": "Double Strap Gold Analog Watch and Layered Bracelet Set",
            "oldPrice": 69,
            "price": 60,
            "discount": 16.69,
            "categoryName": "",
            "image": "https://i5.walmartimages.com/asr/38cdfc6b-bfc9-4cef-a37f-91405c67a556.60f9f2aa5869ab04dc08d9dced115383.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/ca8edfbd-7d24-4821-83f0-6ffd97e121b5.a58074b67f3f3f39170f3187af71d157.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/820e4441-58fe-4437-93d1-9ea06bc9f067.6d808a1fc3987981ac5095914fd5dda9.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            ],
            "noItemsInStock": 16

        },
        {
            "productId": 18,
            "name": "Michael Kors Watch",
            "description": "Michael Kors Women's Wren Chronograph Crystal Pave Watch MK6317",
            "oldPrice": 62,
            "price": 57,
            "discount": 9,
            "categoryName": "",
            "image": "https://i5.walmartimages.com/asr/2dabd22d-42ce-4dee-8af1-7475b4810179_1.5779344f6de0281e3c6bd79b2e09ed52.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/bcb0788f-1625-49de-baf8-1fd5752ed02e_1.f6094b0d9f9ec15a2049e7ba1ff7a2dc.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/57f61bbe-ed7e-448a-8249-937fa2963ddf_1.5e61ee081aad90702a3878a4847a5453.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            ],
            "noItemsInStock": 32
        },
        {
            "productId": 19,
            "name": "Michael Kors Golden Watch",
            "description": "Michael Kors Women's Parker Stainless Steel Rose Gold-Tone Watch, 39mm, MK5491",
            "oldPrice": 54.99,
            "price": 47,
            "discount": 17.55,
            "categoryName": "",
            "image": "https://i5.walmartimages.com/asr/08d0e5fd-bb94-435c-9e7d-9ba0e105afbd_1.78e61a282f7919e655b508a5075ea445.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/413d66fc-8cf4-405d-bfae-00278cde27f5.7b7d7afddaf6bcdb02d32fc6797bbf9a.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/81a6c6c4-f49e-4e2c-b561-d59d4fd7f479_1.d768935ec90649d56159038089dd102a.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            ],
            "noItemsInStock": 54
        },
        {
            "productId": 20,
            "name": "Izndeal Quartz Watch",
            "description": "Minimalist Quartz Watch Glow in The Dark Round Dial Wrist Watch for Casual Daily Office for Women Fashion",
            "oldPrice": 38,
            "price": 35,
            "discount": 8.98,
            "categoryName": "",
            "image": "https://i5.walmartimages.com/asr/5d671f61-8afe-4090-9986-c35373f4d1c4.7f72814629d158db4a2b871abb1683ff.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/0e72d80e-821f-42f1-b58f-a5ddf5c4a0e3.7549e6344729c2421a348dff42d76579.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/7ebb137b-0960-48bf-9a96-109fe434092e.2dcacb39dbb057b544f049d469a2e22a.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            ],
            "noItemsInStock": 22
        }
,
        {
            "productId": 21,
            "name": "Women Hand Bag",
            "description": "Women PU Leather Tote Bag Tassels Leather Shoulder Handbags Fashion Ladies Purses Satchel Messenger Bags - Dark Gray",
            "oldPrice": 52.9,
            "price": 46,
            "discount": 14.65,
            "categoryName": "women-bags",
            "image": "https://i5.walmartimages.com/asr/ad0a093b-b2ff-4e06-8f74-45a75616ec18_1.fab237d27af40ca700c5939d75a755f2.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/10b88352-95fa-48c6-9dcd-54815bab9c61_1.ce4188edc154be19923c76d1cfd2cd7e.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/517767af-0178-42b9-9dad-0b3ccec18fe2_1.c7d8f60adcc26244b27c35a1a0d036f6.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/e69a94eb-8629-4a8d-8253-8e8e0230a498_1.2aa6a3bc0323c6a69052b3a6e6c010dc.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 32
        },
        {
            "productId": 22,
            "name": "Handbag For Girls/Women",
            "description": "Gustavdesign Women Fashion Multi-pocket Canvas Shoulder Bag Casual Hobo Handbags Totes Satchels",
            "oldPrice": 27,
            "price": 23,
            "discount": 17.5,
            "categoryName": "women-bags",
            "image": "https://i5.walmartimages.com/asr/0062d827-156d-405f-9928-1983b795a3e1_1.d6bba7061465be7497ffde3589ab4af3.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/c4fca9de-6fbd-4d3e-afb6-99bac4867a30_1.18e120c5118d5116b9695611eb039d62.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/bc8c6ee6-f084-414c-bf40-0b1b28689353_1.94fe3e4bb6ce7aa5248f145331cf7308.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/a1025f7b-2f7b-4313-81ba-0ee7ac2e62fb_1.9e920659ffdb6dc97f8625d6b41a4942.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 32
        },
        {
            "productId": 23,
            "name": "Patchwork Handmade Bag",
            "description": "Brown Cotton Hobo Crossbody Shoulder Bag Hipster Boho Female Sling.",
            "oldPrice": 48.5,
            "price": 44,
            "discount": 10.39,
            "categoryName": "women-bags",
            "image": "https://i5.walmartimages.com/asr/8466a234-5730-45bc-be35-d8834874e645_1.c5414e980e5828f961556c4f8cb209bb.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/c492a5a2-45ac-4a1d-b890-6c200ad3843f_1.c7e5583a04218b3f42b86292d2234284.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/202f4eae-3b79-44de-9049-3690309bd407_1.896c6f7e97631535d735575376125237.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/04c9ae1f-6cd4-41b5-868f-5550082f8465_1.5291894a600643a719c8256dece7cea4.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 22
        },
        {
            "productId": 24,
            "name": "Crossbody Bag",
            "description": "Handwoven Thick Cotton Shoulder Bag Shopping Market Purse Pink Casual Boho Roomy Spacious.",
            "oldPrice": 63,
            "price": 57,
            "discount": 11.19,
            "categoryName": "women-bags",
            "image": "https://i5.walmartimages.com/asr/67c6b794-5351-4cc4-9889-eec37e9b725f.066c34a9ddcca76b73ca3221a7f1c663.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/71a87ae5-d638-4610-a50b-731d927c1555.4e81f617a9d1bb0e2d8a3f05a24a51ce.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/6cc67c0b-e652-4076-ab4d-b7483d1157c1.5feaa5652935acf444ac94e7b0c389b1.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/8262ae4e-c796-405b-96cb-dac019015878.3229ed508d34eff3012d41eed8b90313.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 24
        },
        {
            "productId": 25,
            "name": "Geometric Handbag",
            "description": "HAWWWY Luminous Geometric Handbag Holographic Reflective Bag Fashion Colorful Purse Cool Color Changing Womens Bag",
            "oldPrice": 78,
            "price": 68,
            "discount": 14.87,
            "categoryName": "women-bags",
            "image": "https://i5.walmartimages.com/asr/53db0e81-7d41-4107-899d-3d0eeb958ff6.5202780b0f2d385f167d2adf820f01c5.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/20752cb5-47a6-49a1-b464-79ca773642cd.91da81fe15e81473865bd130043db1ed.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/a43e0ab4-987a-498a-b7a2-896f4044a8c7.d6b5246a21caee01a02e2afc3c82d4ed.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/e25fef7e-7343-45b1-980c-5af85cd64f33.f52340e69bf9c898762cda7bfd685d76.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 32
        }
,
        {
            "productId": 26,
            "name": "FEISEDY Sun Glasses",
            "description": "FEISEDY Vintage Women Butterfly Sunglasses Designer Luxury Square Gradient Sun Glasses Shades B2486",
            "oldPrice": 23,
            "price": 19,
            "discount": 11,
            "categoryName": "sunglasses",
            "image": "https://i5.walmartimages.com/asr/85166bad-19bb-466e-9d49-d315e0a59d0f.f228bc2d042efe66a12030edc3e8584c.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/b5b4c958-5064-4b9b-9d3f-5f18ffd74be1.91ee2d61e605ad1e57bfc79e0d3f0170.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/af2e9e4c-d113-4b0b-8b42-fa4c342351e6.bd1c2fd4266edc9f6e4872896367e5f9.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/9fad380a-eeb7-40a0-b5eb-f6aba0664d71.1abd2fbda71572a69474725601e6d4ae.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 33
        },

        {
            "productId": 27,
            "name": "FEISEDY Square Sunglass",
            "description": "FEISEDY Square Flat Top Shield Sunglasses One Piece Frameless Stylish Women Men UV400 B2765",
            "oldPrice": 57.5,
            "price": 50,
            "discount": 15.6,
            "categoryName": "sunglasses",
            "image": "https://i5.walmartimages.com/asr/2f554c49-2628-4337-9433-46191439bbba.b517d737905efde993276cbf017f2cf7.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/6599f26b-d44c-4e78-85f7-dc54744d9960.9b552481318fefa2c594586ffad749ee.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/8d5c4d4d-5b3d-4d17-be24-9ba7d906eabe.d5bbb53f8325c21e8d154d263941d09b.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/1766bc5b-bd8c-43e6-9271-0cb934cf546d.8bec3de9945ae7ae12c351399f3cdd87.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 10
        },
        {
            "productId": 28,
            "name": "FEISEDY Sparkling  Glasses",
            "description": "FEISEDY Polarized Women Square Sunglasses Sparkling Composite Shiny Frame B2289",
            "oldPrice": 34,
            "price": 30,
            "discount": 6.33,
            "categoryName": "sunglasses",
            "image": "https://i5.walmartimages.com/asr/8cf52f6d-f2b6-4ade-a0df-c63a48a57a3c.ac082362d36ab90de5bdd984fe43e4fe.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/91dbac45-5923-4359-91c4-60715175fe9d.534a37686534f39c415564f9d0a331e0.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/ee56947d-c625-496d-8ec3-ac07d683bd2a.71ec5a3e7997f3aa8ba909b60773202b.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            ],
            "noItemsInStock": 24
        },
        {
            "productId": 29,
            "name": "FEISEDY Classic Sunglasses",
            "description": "FEISEDY Classic Rimless Sunglasses Women Metal Frame Diamond Cutting Lens Sun Glasses B2567",
            "oldPrice": 31.9,
            "price": 28,
            "discount": 13.89,
            "categoryName": "sunglasses",
            "image": "https://i5.walmartimages.com/asr/116a4b50-94a0-48b1-9130-608f937a22c7.e434e20b23b2e293493cabcfeec2c3aa.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/5ee9ba08-1972-4696-b71c-ea5b9328aa88.f5981a9820925cc6d1b5332c75838015.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/91679f4f-450f-4f0e-8122-917b587c0e41.26b66ea9003717a55217d2865e9a6c85.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/8b94eaa1-9a07-4dc9-95f5-2600827e07b8.74dc051a348b96f2558594d12bb8a581.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 21
        },
        {
            "productId": 30,
            "name": "Foster Grant Men Sunglasses",
            "description": "Foster Grant Mens Deep Dish Way Black Sunglass",
            "oldPrice": 55.6,
            "price": 50,
            "discount": 11.27,
            "categoryName": "sunglasses",
            "image": "https://i5.walmartimages.com/asr/6ee4f10c-df48-4a7f-8a66-28f241598b25.30a8c48e41260d7440b484713457c9cf.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/ad12fa6d-25c7-4758-aa3e-359d20dcb30d.35e3a14dbd1f4c2ffc2d61d78f829e92.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/7d6b9ff6-ddd2-47f5-aa07-8f423d638cd5.7f99cdbcc340556331a665e13cc75a99.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/c33fa482-9b48-487b-9ca8-a55b03f75e81.1af4a03b87432b65abc1f25236b41593.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 10
        }
,
        {
            "productId": 31,
            "name": "half sleeves T shirt",
            "description": "Wrangler Workwear Men's Short Sleeve Pocket Crew Neck Tee",
            "oldPrice": 25.9,
            "price": 23,
            "discount": 12.76,
            "categoryName": "men-shirts",
            "image": "https://i5.walmartimages.com/asr/6f471db3-564b-4eb6-b970-0e26f17a48d6.054d43797d891905c2d133e53cf4bbc7.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/647d1f82-a0cb-42b3-b93e-7055d790fde1.2dafa60da8073a60da023eb8bcce3ea0.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/4aa26fd8-ab58-46b8-8292-838baa07ae56.7f2c5b0d677733862c1e8573018a2293.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/bbddcaa1-774b-456c-9d13-51fbecd37699.a6ef5a4ce7e06ea3b0773020c2eecae9.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 22
        },
        {
            "productId": 32,
            "name": "Lee Men's T Shirt",
            "description": "Lee Men's Vintage Short Sleeve Tee.",
            "oldPrice": 15,
            "price": 10,
            "discount": 14.72,
            "categoryName": "men-shirts",
            "image": "https://i5.walmartimages.com/asr/d7c3c047-5c06-422c-a682-3642c0c004a9.e364934c49831e09fa184ff0265c1e05.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/4cb46d96-27c0-4dcc-a742-095d8b9dd2c3.04b72ee1babbd1f6728427f3436245df.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/c8237a81-53c8-4b92-9baa-79c47a30e1eb.e7343f9436f3a9003b1a9cfa29e166e0.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/f042f662-f4db-42ad-8dfd-5691377c25fd.67f78a953d0c98db4f520061438248a0.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 20
        },
        {
            "productId": 33,
            "name": "Athletic high quality T shirts",
            "description": "Athletic Works Men's Active Core Short Sleeve T-Shirt",
            "oldPrice": 39,
            "price": 35,
            "discount": 7.54,
            "categoryName": "men-shirts",
            "image": "https://i5.walmartimages.com/asr/f064a814-117b-427e-ad37-54a89e352338.a85847e9d17522a86e618c9a44d67c68.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/b40d5ac7-9803-42b1-8395-e2ab58dff2e4.59ced6e3d3f0bb5acd22a7e50d4ae7be.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/192e3f0d-63b3-4d7c-aa4e-695142fb0970.8c1a35132a92877bb556e96012aeeeb4.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/0a651575-0a8c-4617-be66-022ee89b8069.1593878fb2fab835fba69e708935a134.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 5
        },
        {
            "productId": 34,
            "name": "Reebok Men's T-Shirt",
            "description": "Reebok Men's and Big Men's Active Short Sleeve Camo Delta Logo Tee.",
            "oldPrice": 53.5,
            "price": 46,
            "discount": 16.44,
            "categoryName": "men-shirts",
            "image": "https://i5.walmartimages.com/asr/ae1c71f9-a080-4686-a37c-a0665de2498a.317ad7e51607caa93c186ba8b4042746.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/058af057-5ac7-4f49-928d-3aba95454bb7.e569b0c7a126876b9179b39114f7dd28.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/c8e0c155-65c2-4630-af63-64ddd36f5bec.db49954306e0bddca5fd3fd50c60f9a7.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/561cebfe-a187-45c2-9346-f1ebd15b538d.c55d08a3a6130cac7e6ae6323e3dda98.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 7
        },
        {
            "productId": 35,
            "name": "Reebok Men's T-Shirt",
            "description": "Reebok Men's Duration Quick Dry Short Sleeve Athletic T-Shirt",
            "oldPrice": 76,
            "price": 66,
            "discount": 15.97,
            "categoryName": "men-shirts",
            "image": "https://i5.walmartimages.com/asr/96cd9770-08e4-4b84-8f54-519cbf5b50c6.eb0781652fbb8d4584829ade893586dd.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/46164d7b-201d-42b5-bf8a-514d201818e3.0078c55d1985c1db93c8c7bd1380c7e8.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/f55786d6-a25f-481b-8775-037f3140b21b.fbdcf23b74d4f66a72bae218a89735aa.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/732d8e4f-7dcc-4b06-860f-2cbb209a0f5a.6a3714ee4d75b852f2b5b46292a4ef55.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 14
        }
,
        {
            "productId": 36,
            "name": "Leather Straps Wristwatch",
            "description": "Style:Casual ,Leather Strap ,Water Resistance",
            "oldPrice": 128,
            "price": 120,
            "discount": 7.14,
            "categoryName": "men-watches",
            "image": "https://i5.walmartimages.com/asr/03c5e9de-3279-4b8f-a466-8ec3bef52be2_1.85b88bb2ba6ec76a3758dd134eadefba.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/767dbc94-cfe6-4016-9e9c-3c58ba940b06_1.abefbff9f378b876fbb00f04d48acde0.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/6efa1b35-6eea-4a7f-8b55-752b4e5e2737_1.81cb17df169405651f67bd850263a094.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/ada6f9d0-5ae9-4805-bac1-f35bb1c0137d_1.66cfcb8cf279e6406283a13cc1afdd05.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 12
        },
        {
            "productId": 37,
            "name": "Invicta Watch",
            "description": "Invicta Pro Diver Mens 40mm Two Tone Quartz Watch",
            "oldPrice": 48,
            "price": 46,
            "discount": 3.15,
            "categoryName": "men-watches",
            "image": "https://i5.walmartimages.com/asr/aae7459a-57c6-4f86-b0dd-682f916b1242.7866d04d4fe94a6f60ab77fe3b7e13e4.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/85bbb6bb-395c-429f-86aa-d366b1d82554_1.c522d43a4d3e239042182cbbb7c4a6ab.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/e00346de-424d-4e2e-a2a3-304cc542b5ed_1.fa999f426052ed6c6029533e2fdb5260.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            ],
            "noItemsInStock": 41
        },
        {
            "productId": 38,
            "name": "Casio Men's Watch",
            "description": "Casio Men's Dive Style Watch, Black MRW200H-1BV",
            "oldPrice": 51.3,
            "price": 50,
            "discount": 2.56,
            "categoryName": "men-watches",
            "image": "https://i5.walmartimages.com/asr/7ec0b013-ca55-45c0-b49b-bf1715e6dae4_1.51d5badcb8117f36d0960112eeab2288.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/c22acdef-65a3-45ca-9033-d6aabb6935f9_1.3a843d47f3e6827913c84fe60df6ed6b.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/c3fdf9a7-0f61-476b-b28b-31b91ea2e437_1.ae328f99ec82678f3dd92ab8434bc1d4.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/7f4ab615-6b21-47f9-881a-07fed96c84bf_1.d360dbc58fb1c181a62b51350e74012e.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 5
        },
        {
            "productId": 39,
            "name": "Casio Men's Watch",
            "description": "Casio Men's Ana-Digi Databank 10-Year Battery Watch, Black Resin Strap",
            "oldPrice": 50,
            "price": 46,
            "discount": 10.2,
            "categoryName": "men-watches",
            "image": "https://i5.walmartimages.com/asr/f4937fc5-80e8-4268-ad2e-cc95a1756723.9a3657fdf3406627b40250977215eb7f.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/b9e42764-86e5-4bbc-8596-9c6605724208.90aeeed3ddfdf700a9072cc36e0de240.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/56b465d4-7c8c-49e1-96bc-a10efb88db54.9279cf85d628949563d54538d032efea.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            ],
            "noItemsInStock": 24
        },
        {
            "productId": 40,
            "name": "Stainless Steel Wrist Watch",
            "description": "Men Business Quartz Watch Wristwatches Stainless Steel Belt RYSTE",
            "oldPrice": 54.5,
            "price": 47,
            "discount": 17.79,
            "categoryName": "men-watches",
            "image": "https://i5.walmartimages.com/asr/5674324f-447a-47d3-bb9c-497e81beb721_1.13aa71bb4d761520110229a04ff1bba7.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/2f9c4bdc-19c7-41c8-92aa-52d32a66124a_1.bdcfc74f8a8eeca13b7cdbed831fdbc1.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/a8d5041f-7414-4aca-9ec4-66636a9b7169_1.b8e26b3024530a1921ffa34795d85cb2.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            ],
            "noItemsInStock": 14
        }
,
        {
            "productId": 41,
            "name": "Morphy Richards 305003",
            "description": "Steam Iron with Intellitemp No Burns Guaranteed, 2400 W, 350 milliliters, Blue",
            "oldPrice": 120,
            "price": 100,
            "discount": 10,
            "categoryName": "irons",
            "image": "https://m.media-amazon.com/images/I/51E8+iidwnL._AC_SL1000_.jpg",
            "prodImages": [
                "https://m.media-amazon.com/images/I/619yRoLAYDL._AC_SL1000_.jpg",
                "https://m.media-amazon.com/images/I/61LpUUWdOsL._AC_SL1181_.jpg",
            ],
            "noItemsInStock": 4
        },
        {
            "productId": 42,
            "name": "Russell Hobbs",
            "description": "Supreme Steam Traditional Iron 23060, 2400 W, Purple/White",
            "oldPrice": 80,
            "price": 68,
            "discount": 15,
            "categoryName": "irons",
            "image": "https://m.media-amazon.com/images/I/61Ky4K-vRIL._AC_SL1000_.jpg",
            "prodImages": [
                "https://m.media-amazon.com/images/I/41ZNUMmXvmL._AC_.jpg",
                "https://m.media-amazon.com/images/I/71qB19wGopL._AC_SL1165_.jpg",
                "https://m.media-amazon.com/images/I/81-+8dtDKCL._AC_SL1500_.jpg",
                "https://m.media-amazon.com/images/I/71d9s3sWkYL._AC_SL1500_.jpg"
            ],
            "noItemsInStock": 10
        },
        {
            "productId": 43,
            "name": "Philips PerfectCare Elite Steam Generator.",
            "description": "2400W, 470g Steam Boost, 6.7 Bar Pressure, OptimalTEMP Technology, 1.8L Tank, Blue/White (GC9630/20)",
            "oldPrice": 85,
            "price": 72.25,
            "discount": 15,
            "categoryName": "irons",
            "image": "https://m.media-amazon.com/images/I/61FLK+MY9aL._AC_SL1139_.jpg",
            "prodImages": [
                "https://m.media-amazon.com/images/I/91I2aF4hXHL._AC_SL1500_.jpg",
                "https://m.media-amazon.com/images/I/91fYPwKjZ5L._AC_SL1500_.jpg",
                "https://m.media-amazon.com/images/I/71ubmgnxh1L._AC_SL1349_.jpg",
            ],
            "noItemsInStock": 17
        },
        {
            "productId": 44,
            "name": "Clothes Steamer 1000W with Static Brush",
            "description": "Compact Design,25gr/min,120ml Tank,Portable Garment Steamer for Home Travel",
            "oldPrice": 90,
            "price": 85.5,
            "discount": 5,
            "categoryName": "irons",
            "image": "https://m.media-amazon.com/images/I/51a1LKGVmAL._AC_SL1500_.jpg",
            "prodImages": [
                "https://m.media-amazon.com/images/I/71+l1GvBvCL._AC_SL1500_.jpg",
                "https://m.media-amazon.com/images/I/61hjxWoQbfL._AC_SL1500_.jpg",
                "https://m.media-amazon.com/images/I/71QPavHg43L._AC_SL1500_.jpg",
                "https://m.media-amazon.com/images/I/51a1LKGVmAL._AC_SL1500_.jpg"
            ],
            "noItemsInStock": 27
        },
        {
            "productId": 45,
            "name": "Tower T22008RG CeraGlide",
            "description": "Cordless Steam Iron with Ceramic Soleplate and Variable Steam Function, Rose Gold",
            "oldPrice": 90,
            "price": 85.5,
            "discount": 5,
            "categoryName": "irons",
            "image": "https://m.media-amazon.com/images/I/51qB7kR+GUL._AC_SL1350_.jpg",
            "prodImages": [
                "https://m.media-amazon.com/images/I/61s0EbNgjcL._AC_SL1350_.jpg",
                "https://m.media-amazon.com/images/I/610qhY+pOjL._AC_SL1350_.jpg",
                "https://m.media-amazon.com/images/I/71YyBPGAjkL._AC_SL1350_.jpg",
                "https://m.media-amazon.com/images/I/61vQKMtQ36L._AC_SL1350_.jpg"
            ],
            "noItemsInStock": 30
        },
        {
            "productId": 46,
            "name": "Stratus No.2 Professional steamer",
            "description": "A floor standing vertical steamer. Our best steamer for clothes and textiles. [Energy Class A+++]",
            "oldPrice": 138,
            "price": 120,
            "discount": 15,
            "categoryName": "irons",
            "image": "https://m.media-amazon.com/images/I/61xL6hbtfbL._AC_SL1500_.jpg",
            "prodImages": [
                "https://m.media-amazon.com/images/I/71qXk2NU1jL._AC_SL1500_.jpg",
                "https://m.media-amazon.com/images/I/61th1RWDrdL._AC_SL1500_.jpg",
                "https://m.media-amazon.com/images/I/71Nk+uAHSNL._AC_SL1500_.jpg",
                "https://m.media-amazon.com/images/I/71Y1HYF4yBL._AC_SL1500_.jpg"
            ],
            "noItemsInStock": 17
        },
        {
            "productId": 47,
            "name": "Garment Steamer for Clothes.",
            "description": "Standing Professional Clothes Steamer Upright with Ironing Pad ,3.2L Large Water Tank 1750W Black",
            "oldPrice": 138,
            "price": 120,
            "discount": 15,
            "categoryName": "irons",
            "image": "https://m.media-amazon.com/images/I/617R34aPuZL._AC_SL1500_.jpg",
            "prodImages": [
                "https://m.media-amazon.com/images/I/71JD8YZorhL._AC_SL1500_.jpg",
                "https://m.media-amazon.com/images/I/81oAlmkKHQL._AC_SL1500_.jpg",
                "https://m.media-amazon.com/images/I/61t53iCVBtL._AC_SL1500_.jpg",
            ],
            "noItemsInStock": 18
        },
        {
            "productId": 48,
            "name": "Comfort Zone Cooling fan.",
            "description": "Comfort Zone 16 3-Speed Adjustable-Height Oscillating Pedestal Fan with Quad-Pod® Folding Base, Black",
            "oldPrice": 55,
            "price": 50,
            "discount": 8,
            "categoryName": "fans",
            "image": "https://i5.walmartimages.com/asr/86701e81-518e-4b53-9cba-65379618a009.68987da722961eebb800992584abdf21.png?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/a53ca7a9-a331-4b9b-a390-5efe178b86af.b4f4cf890f4765e8a4b655079aa8fd03.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/487cfce8-fc70-4055-a682-c8236a294887.7948ccea4520f97e0a5a2094c2198122.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/4d81e979-3dac-47ff-8f8e-49c33e3362cb.d64e0e53a3a4e149e5bf934565867b75.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            ],
            "noItemsInStock": 10
        },
        {
            "productId": 49,
            "name": "Steel Floor Fan.",
            "description": "Mainstays 20 inch 360 Degree Pivot High Velocity Steel Floor Fan , Black",
            "oldPrice": 55,
            "price": 50,
            "discount": 8,
            "categoryName": "fans",
            "image": "https://i5.walmartimages.com/asr/840bd7dc-497d-406e-a5e1-52b053c60089_1.7b626eb54cb5e5ea2d3d02dcf17f51cb.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/1880b4d6-0fc0-409c-8ca5-9d2aa53567fe_1.05f24155b3e333e90d8b48b90a1da9a9.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/01fca0cd-6d59-486f-81b4-605b9c7e0207_1.2d0c17e47539cc4e538be39960e21c13.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            ],
            "noItemsInStock": 12
        },
        {
            "productId": 50,
            "name": "Box Fan.",
            "description": "Mainstays 20 3-Speed Box Fan, Model# FB50-16HL, Blue",
            "oldPrice": 30,
            "price": 31.4,
            "discount": 4,
            "categoryName": "fans",
            "image": "https://i5.walmartimages.com/asr/e8bf5cc3-fabb-4496-b6aa-e95ec3a9101d_2.6b3b08410d7e8d69ea69d32c694acadb.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/d79b28a4-5d51-4de2-bb27-683f3d7f48b7.370dbb965c87ceaaf0312d72543f4833.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/b431a3ab-7b55-4982-8c5f-47fa909f9600.76096863932cc4caf97071eade57e1d2.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/0215da7f-219f-4e0a-be6e-43bde3d8aab7_1.17b22466d216e0f873e85a084602fa17.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 18
        },
        {
            "productId": 51,
            "name": "Celing Fan.",
            "description": "Bestco 42 Industrial Ceiling Fan w Retractable Blades Cage Shade for 60W Light Bulbs",
            "oldPrice": 220,
            "price": 198,
            "discount": 10,
            "categoryName": "fans",
            "image": "https://i5.walmartimages.com/asr/14c942ea-7fb8-4f04-bf8b-851b9a32c5d3.9e4e8597fd3a71065c3ca8cee1620aa9.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/7d103b1c-732b-48ad-a425-09441c1b2734.6bd707f6454b91c1efe7d573adb5828d.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/d52cee4d-42da-49f6-9c4b-22bf6282589a.9becb1c201da812cd69e965ba1405089.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/67d73df7-ed71-4532-9b01-7839bbbc7598.bb380e020354415422d976a1875b05aa.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF"
            ],
            "noItemsInStock": 12
        },
        {
            "productId": 52,
            "name": "Celing Fan.",
            "description": "ALUOCYI Down Rod 42 Inch Ceiling Fan with Lights and Remote, 5 Blades Matte Black Ceiling Fan,Reverse Airflow",
            "oldPrice": 340,
            "price": 306,
            "discount": 10,
            "categoryName": "fans",
            "image": "https://i5.walmartimages.com/asr/5f8d2b1f-d92d-4b40-8a7d-564d708b0df0.d28ca10080f92b33e483c1c3579af8b9.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            "prodImages": [
                "https://i5.walmartimages.com/asr/befa0edf-ac4c-4813-888e-38efa9bd86f6.4308093b73fbe790c725f42c8ddcf9a7.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
                "https://i5.walmartimages.com/asr/f7007ff4-4562-4e4e-95e7-310b611abe0e.04ab1f8165625fb6f4a0453e88ab94af.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF",
            ],
            "noItemsInStock": 10
        },

    



];
   WidgetsFlutterBinding.ensureInitialized();
   return SingleChildScrollView(
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
          children: [

              TextField(
                decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'userId price',
                hintText: 'product old price',
              ),
                keyboardType: TextInputType.number ,
                onChanged: (value){
                  userId = value;
                },
            ),
                 TextField(
                decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'productId ',
                hintText: 'productId  ',
              ),
                keyboardType: TextInputType.number ,
                onChanged: (value){
                  productId = value;
                },
            ),
            //   TextField(
            //     decoration: const InputDecoration(
            //       border: OutlineInputBorder(),
            //       labelText: 'productId',
            //       hintText: 'productId price',
            //     ),
            //     keyboardType: TextInputType.number ,
            //     onChanged: (value){
            //       state = value;
            //     },
            //   ),
   
            //   TextField(
            //     decoration: const InputDecoration(
            //       border: OutlineInputBorder(),
            //       labelText: 'prodId1',
            //       hintText: 'prodId1',
            //     ),
            //     keyboardType: TextInputType.number ,
            //     controller: prod1,
            //   ),

            //  TextField(
            //     decoration: const InputDecoration(
            //       border: OutlineInputBorder(),
            //       labelText: 'prodId2',
            //       hintText: 'prodId2',
            //     ),
            //     keyboardType: TextInputType.number ,
            //     controller: Prod2,
            //   ),
//               ElevatedButton(onPressed: ()async{
//               // try {
//               //   productIds.add(prod1.text);
//               //   productIds.add(Prod2.text);
//               //   OrderModel orderModel = OrderModel(userId: userId!, prodIds: productIds, state: state!);
//               //   await  FireStoreOrder().addOrderToFireStore(orderModel);
//               //   productIds.clear();
//               // } catch (e) {
//               //   print(e.toString());
//               // }
// try {
               
//                 WishListModel wishListModel = WishListModel(userId: userId!,productId: productId!);
//                 await  FireStoreWishList().addItemToWishListFireStore(wishListModel);
//                 productIds.clear();
//               } catch (e) {
//                 print(e.toString());
//               }
//             }, child:const Text("Add")),


            
              ElevatedButton(onPressed: (){
              FireStoreOrder().getOrders();
            }, child: Text("Get"),),

             ElevatedButton(onPressed: (){
              products.forEach((element) {
                var id= FirebaseFirestore.instance.collection("products").doc().id;
                    FirebaseFirestore.instance.collection("products")
                        .doc(id).set(element);
                  });
            },
             child: Text("Push Categories data To FireStore"),),
             ElevatedButton(onPressed: (){
              products.forEach((element) {
                var id= FirebaseFirestore.instance.collection("products").doc().id;
                    FirebaseFirestore.instance.collection("products")
                        .doc(id).set(element);
                  });
            }, child: Text("Push Products data To FireStore"),),
            ElevatedButton(onPressed: (){
              Setstate(){
                currentIndex = 2;
          }

            }, child: Text("$currentIndex"))
          ],
       ),
     ),
   );


  }
}