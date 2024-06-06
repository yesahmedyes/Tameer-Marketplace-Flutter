# Tameer

<br>

<h4>I built an app for construction materials marketplace. Everything from design and implementation was done by me. I tried to focus on two things:</h4>

Good app performace - For this I have implemented concepts such as a debouncer and preemptive deletion

Good user experience - I built the app iteratively to make sure the design and screen flows are very intuitive. My research showed that most of the cusomter base prefers Roman Urdu over nomral Urdu or Engligh. For this reason, I tried to user Roman Urdu everywhere in the app.

<br>

<h4>User Authentication</h4>

The app starts with a Get Started page, followed by user authentication using Firebase.

The wave patterns in the background are made using CustomPainter.

<p align="center"><img src="https://github.com/yesahmedyes/tameer-app/blob/main/demo/1.jpg" width="100%"></p>

<br>

<h4>Main Screen</h4>

The main screen consists of a App Bar that shows a Menu icon and a Cart Icon, a Bottom Navigation for Home and Orders.

Home consists of different categories of products and Orders consists of a List of history of orders.

The two switch between each other using PageView.

<p align="center"><img src="https://github.com/yesahmedyes/tameer-app/blob/main/demo/2.jpg" width="100%"></p>

<br>

<h4>Products</h4>

Once you tap on a Category, you are offered with a GridView of Products for that Category.

Once you tap on that, you are taken to the ProductDetail screen.

You can see the product description in the form of a full screen Dialog.

You are given an option to add the product to Cart or Buy Now.

<p align="center"><img src="https://github.com/yesahmedyes/tameer-app/blob/main/demo/3.jpg" width="100%"></p>

<br>

<h4>Cart</h4>

When you go to the Cart, you can see a List of your CartItems.

When you tap to proceed, you are asked to enter your address.

When you tap proceed again, you are given an option for instant or scheduled delivery. You can select a date using CupertinoDatePicker.

When you tap proceed again, you are taken to the Checkout page where you can tap Confirm Order to place the order.

<p align="center"><img src="https://github.com/yesahmedyes/tameer-app/blob/main/demo/4.jpg" width="100%"></p>
<p align="center"><img src="https://github.com/yesahmedyes/tameer-app/blob/main/demo/5.jpg" width="100%"></p>

<br>

<h4>Some other features</h4>

Bloc is used for State management

The app is separated into 3 layers: Presentation, Logic and Data

Flutter Toast is implmeted to give user feedback on action such as Adding to Cart or Placing an Order.

Hive is used to store profile details locally.

Reorder items is implemented so that user can place the same order without having to add address and other details again.

Image Caching is used so that the smae images don't have to be downloaded again.

Different colors are used for Order Status, along with Order Tracking.

<br>

<h4>To see a screen recording of the app: </h4> <a href="https://drive.google.com/file/d/1ZF6XRPTQzp7JsKW4nZtSyk7W-2w3gCbf/view?usp=sharing" target="_blank">https://drive.google.com/file/d/1ZF6XRPTQzp7JsKW4nZtSyk7W-2w3gCbf/view?usp=sharing</a>
