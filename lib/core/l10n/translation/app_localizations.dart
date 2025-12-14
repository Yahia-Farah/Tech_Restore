import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'translation/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Tech & Restore'**
  String get app_name;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @repair.
  ///
  /// In en, this message translates to:
  /// **'Repair History'**
  String get repair;

  /// No description provided for @devices.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get devices;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @invoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoices;

  /// No description provided for @inventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory;

  /// No description provided for @offers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offers;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @today_sales.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Sales'**
  String get today_sales;

  /// No description provided for @new_orders.
  ///
  /// In en, this message translates to:
  /// **'New Orders'**
  String get new_orders;

  /// No description provided for @reply_notifications.
  ///
  /// In en, this message translates to:
  /// **'Reply Notifications'**
  String get reply_notifications;

  /// No description provided for @customer_satisfaction.
  ///
  /// In en, this message translates to:
  /// **'Customer Satisfaction'**
  String get customer_satisfaction;

  /// No description provided for @latest_orders.
  ///
  /// In en, this message translates to:
  /// **'Latest Orders'**
  String get latest_orders;

  /// No description provided for @order_code.
  ///
  /// In en, this message translates to:
  /// **'Order Code'**
  String get order_code;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @order_status.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get order_status;

  /// No description provided for @order_details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get order_details;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @shipped.
  ///
  /// In en, this message translates to:
  /// **'Shipped'**
  String get shipped;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @inventory_alerts.
  ///
  /// In en, this message translates to:
  /// **'Inventory Alerts'**
  String get inventory_alerts;

  /// No description provided for @low_stock.
  ///
  /// In en, this message translates to:
  /// **'Low stock'**
  String get low_stock;

  /// No description provided for @samsung_screen.
  ///
  /// In en, this message translates to:
  /// **'Samsung A16 Screen'**
  String get samsung_screen;

  /// No description provided for @samsung_charger.
  ///
  /// In en, this message translates to:
  /// **'Samsung A16 Charger'**
  String get samsung_charger;

  /// No description provided for @devices_management.
  ///
  /// In en, this message translates to:
  /// **'Devices Management'**
  String get devices_management;

  /// No description provided for @devices_management_desc.
  ///
  /// In en, this message translates to:
  /// **'Describe your device...'**
  String get devices_management_desc;

  /// No description provided for @add_device.
  ///
  /// In en, this message translates to:
  /// **'Add Device'**
  String get add_device;

  /// No description provided for @device_types.
  ///
  /// In en, this message translates to:
  /// **'Device Types'**
  String get device_types;

  /// No description provided for @search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search by device name, type, serial number...'**
  String get search_hint;

  /// No description provided for @device_status.
  ///
  /// In en, this message translates to:
  /// **'Device Status'**
  String get device_status;

  /// No description provided for @all_types.
  ///
  /// In en, this message translates to:
  /// **'All Types'**
  String get all_types;

  /// No description provided for @device_name.
  ///
  /// In en, this message translates to:
  /// **'Device Name'**
  String get device_name;

  /// No description provided for @device_type.
  ///
  /// In en, this message translates to:
  /// **'Device Type'**
  String get device_type;

  /// No description provided for @serial_number.
  ///
  /// In en, this message translates to:
  /// **'Serial Number'**
  String get serial_number;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @newDev.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newDev;

  /// No description provided for @used.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get used;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @repair_requests_title.
  ///
  /// In en, this message translates to:
  /// **'Repair Requests'**
  String get repair_requests_title;

  /// No description provided for @repair_requests_subtitle.
  ///
  /// In en, this message translates to:
  /// **'You can view all customer repair requests, accept them, and update their status here'**
  String get repair_requests_subtitle;

  /// No description provided for @status_filter.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get status_filter;

  /// No description provided for @status_received.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get status_received;

  /// No description provided for @status_in_progress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get status_in_progress;

  /// No description provided for @status_completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get status_completed;

  /// No description provided for @table_client.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get table_client;

  /// No description provided for @table_device.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get table_device;

  /// No description provided for @table_issue.
  ///
  /// In en, this message translates to:
  /// **'Issue'**
  String get table_issue;

  /// No description provided for @table_status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get table_status;

  /// No description provided for @table_date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get table_date;

  /// No description provided for @table_action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get table_action;

  /// No description provided for @orders_title.
  ///
  /// In en, this message translates to:
  /// **'Purchase Orders'**
  String get orders_title;

  /// No description provided for @orders_subtitle.
  ///
  /// In en, this message translates to:
  /// **'You can track customer purchases from here'**
  String get orders_subtitle;

  /// No description provided for @last_orders.
  ///
  /// In en, this message translates to:
  /// **'Last Orders'**
  String get last_orders;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @customer_info.
  ///
  /// In en, this message translates to:
  /// **'Customer Info'**
  String get customer_info;

  /// No description provided for @payment_details.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get payment_details;

  /// No description provided for @payment_method.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get payment_method;

  /// No description provided for @order_items.
  ///
  /// In en, this message translates to:
  /// **'Order Items'**
  String get order_items;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product;

  /// No description provided for @track_order.
  ///
  /// In en, this message translates to:
  /// **'Track Order'**
  String get track_order;

  /// No description provided for @order_placed.
  ///
  /// In en, this message translates to:
  /// **'Order Placed'**
  String get order_placed;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// No description provided for @egp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp;

  /// No description provided for @transactions_title.
  ///
  /// In en, this message translates to:
  /// **'Income & Revenues'**
  String get transactions_title;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @transactions_subtitle.
  ///
  /// In en, this message translates to:
  /// **'You can view the monthly or yearly income for repair orders and sales from here'**
  String get transactions_subtitle;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @search_hint_shop.
  ///
  /// In en, this message translates to:
  /// **'Search repair shops...'**
  String get search_hint_shop;

  /// No description provided for @total_profits.
  ///
  /// In en, this message translates to:
  /// **'Total Profits'**
  String get total_profits;

  /// No description provided for @repairs_percent.
  ///
  /// In en, this message translates to:
  /// **'Repairs (%{percent})'**
  String repairs_percent(Object percent);

  /// No description provided for @sales_percent.
  ///
  /// In en, this message translates to:
  /// **'Sales (%{percent})'**
  String sales_percent(Object percent);

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @service_type.
  ///
  /// In en, this message translates to:
  /// **'Service Type'**
  String get service_type;

  /// No description provided for @device.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get device;

  /// No description provided for @shop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shop;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @out_for_delivery.
  ///
  /// In en, this message translates to:
  /// **'Out for delivery'**
  String get out_for_delivery;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @inventory_title.
  ///
  /// In en, this message translates to:
  /// **'Inventory System'**
  String get inventory_title;

  /// No description provided for @inventory_description.
  ///
  /// In en, this message translates to:
  /// **'You can monitor the number of devices and see if a product is running low from here'**
  String get inventory_description;

  /// No description provided for @inventory_search.
  ///
  /// In en, this message translates to:
  /// **'Search inventory...'**
  String get inventory_search;

  /// No description provided for @inventory_add_product.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get inventory_add_product;

  /// No description provided for @inventory_add_csv.
  ///
  /// In en, this message translates to:
  /// **'Add CSV'**
  String get inventory_add_csv;

  /// No description provided for @inventory_export_csv.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get inventory_export_csv;

  /// No description provided for @inventory_product_name.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get inventory_product_name;

  /// No description provided for @inventory_category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get inventory_category;

  /// No description provided for @inventory_price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get inventory_price;

  /// No description provided for @inventory_quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get inventory_quantity;

  /// No description provided for @inventory_status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get inventory_status;

  /// No description provided for @inventory_action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get inventory_action;

  /// No description provided for @inventory_total_products.
  ///
  /// In en, this message translates to:
  /// **'Total Products'**
  String get inventory_total_products;

  /// No description provided for @inventory_low_stock.
  ///
  /// In en, this message translates to:
  /// **'Low Stock Products'**
  String get inventory_low_stock;

  /// No description provided for @inventory_total_price.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get inventory_total_price;

  /// No description provided for @inventory_currency.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get inventory_currency;

  /// No description provided for @inventory_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get inventory_edit;

  /// No description provided for @inventory_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get inventory_delete;

  /// No description provided for @offersTitle.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offersTitle;

  /// No description provided for @offersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can add and manage offers and discounts'**
  String get offersSubtitle;

  /// No description provided for @searchOffers.
  ///
  /// In en, this message translates to:
  /// **'Search in offers...'**
  String get searchOffers;

  /// No description provided for @addNewOffer.
  ///
  /// In en, this message translates to:
  /// **'New Offer'**
  String get addNewOffer;

  /// No description provided for @offerColumnTitle.
  ///
  /// In en, this message translates to:
  /// **'Offer'**
  String get offerColumnTitle;

  /// No description provided for @offerColumnContent.
  ///
  /// In en, this message translates to:
  /// **'Offer Description'**
  String get offerColumnContent;

  /// No description provided for @offerColumnDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discount %'**
  String get offerColumnDiscount;

  /// No description provided for @offerColumnDuration.
  ///
  /// In en, this message translates to:
  /// **'Offer Duration'**
  String get offerColumnDuration;

  /// No description provided for @offerColumnStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get offerColumnStatus;

  /// No description provided for @offerColumnActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get offerColumnActions;

  /// No description provided for @ofShow.
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get ofShow;

  /// No description provided for @toShow.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get toShow;

  /// No description provided for @supportTitle.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get supportTitle;

  /// No description provided for @supportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can view all customer issues and inquiries here'**
  String get supportSubtitle;

  /// No description provided for @searchSupport.
  ///
  /// In en, this message translates to:
  /// **'Search support requests...'**
  String get searchSupport;

  /// No description provided for @allStatus.
  ///
  /// In en, this message translates to:
  /// **'All Status'**
  String get allStatus;

  /// No description provided for @openStatus.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get openStatus;

  /// No description provided for @inProgressStatus.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgressStatus;

  /// No description provided for @resolvedStatus.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get resolvedStatus;

  /// No description provided for @tableRequestId.
  ///
  /// In en, this message translates to:
  /// **'Request ID'**
  String get tableRequestId;

  /// No description provided for @tableCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get tableCustomer;

  /// No description provided for @tableContent.
  ///
  /// In en, this message translates to:
  /// **'Request Content'**
  String get tableContent;

  /// No description provided for @tablePriority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get tablePriority;

  /// No description provided for @tableStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get tableStatus;

  /// No description provided for @tableLastUpdate.
  ///
  /// In en, this message translates to:
  /// **'Last Update'**
  String get tableLastUpdate;

  /// No description provided for @tableActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get tableActions;

  /// No description provided for @requestsCount.
  ///
  /// In en, this message translates to:
  /// **'requests'**
  String get requestsCount;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to TechRestore!'**
  String get welcome;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get login;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home Page'**
  String get home;

  /// No description provided for @deviceIssue.
  ///
  /// In en, this message translates to:
  /// **'Device issue'**
  String get deviceIssue;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @liveStu.
  ///
  /// In en, this message translates to:
  /// **'Live status updates'**
  String get liveStu;

  /// No description provided for @trackingNumber.
  ///
  /// In en, this message translates to:
  /// **'Tracking number'**
  String get trackingNumber;

  /// No description provided for @repairStatue.
  ///
  /// In en, this message translates to:
  /// **'Repair Status'**
  String get repairStatue;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Let’s Get Started'**
  String get start;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @uploadPorV.
  ///
  /// In en, this message translates to:
  /// **'Upload photos or videos'**
  String get uploadPorV;

  /// No description provided for @describeIssue.
  ///
  /// In en, this message translates to:
  /// **'Describe the issue'**
  String get describeIssue;

  /// No description provided for @deviceIssueQuote.
  ///
  /// In en, this message translates to:
  /// **'What\'s the issue with your Device?'**
  String get deviceIssueQuote;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get username;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add a photo'**
  String get addPhoto;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgetPassword;

  /// No description provided for @withGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get withGoogle;

  /// No description provided for @newOrder.
  ///
  /// In en, this message translates to:
  /// **'New order'**
  String get newOrder;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @whatRepair.
  ///
  /// In en, this message translates to:
  /// **'What do you need to repair?'**
  String get whatRepair;

  /// No description provided for @newUser.
  ///
  /// In en, this message translates to:
  /// **'New User Sign Up'**
  String get newUser;

  /// No description provided for @signUpQuote.
  ///
  /// In en, this message translates to:
  /// **'Get your tech fixed, fast.'**
  String get signUpQuote;

  /// No description provided for @secSignUpQuote.
  ///
  /// In en, this message translates to:
  /// **'We\'ll connect you with the best local shops to get your device fixed.'**
  String get secSignUpQuote;

  /// No description provided for @byContinuing.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to the Terms of Use. Read our Privacy Policy.'**
  String get byContinuing;

  /// No description provided for @startQuote.
  ///
  /// In en, this message translates to:
  /// **'Your one-stop solution for all tech mishaps. From broken screens to sluggish laptops, we\'ll connect you to reliable repair services. Let\'s get your devices back to their prime! Tap to begin.'**
  String get startQuote;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'explore'**
  String get explore;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @loginSuccessMsg.
  ///
  /// In en, this message translates to:
  /// **'Login Successfully'**
  String get loginSuccessMsg;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @are_you_sure_logout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get are_you_sure_logout;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @invalidPasswordMsg.
  ///
  /// In en, this message translates to:
  /// **'Invalid password'**
  String get invalidPasswordMsg;

  /// No description provided for @passwordErrorMatchingMsg.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match!'**
  String get passwordErrorMatchingMsg;

  /// No description provided for @updateText.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateText;

  /// No description provided for @logoutAlertMsg.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutAlertMsg;

  /// No description provided for @logoutConfirmTextCenter.
  ///
  /// In en, this message translates to:
  /// **'Confirm logout!'**
  String get logoutConfirmTextCenter;

  /// No description provided for @resetPasswordUnderMsg.
  ///
  /// In en, this message translates to:
  /// **'Password must not be empty and must contain at least 6 characters with one uppercase letter and one number'**
  String get resetPasswordUnderMsg;

  /// No description provided for @emailVerificationScreen.
  ///
  /// In en, this message translates to:
  /// **'Email Verification'**
  String get emailVerificationScreen;

  /// No description provided for @emailVerificationScreenUnderMsg.
  ///
  /// In en, this message translates to:
  /// **'Please enter the code that was sent to your\nemail address'**
  String get emailVerificationScreenUnderMsg;

  /// No description provided for @codeReceiveMsgError.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code?'**
  String get codeReceiveMsgError;

  /// No description provided for @forgetPasswordUnderText.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email associated with\nyour account'**
  String get forgetPasswordUnderText;

  /// No description provided for @validationEmailErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'This email is not valid'**
  String get validationEmailErrorMessage;

  /// No description provided for @requiredEmailErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get requiredEmailErrorMessage;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @newPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordLabel;

  /// No description provided for @newPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get newPasswordHint;

  /// No description provided for @wrongPasswordErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'Wrong password, try again'**
  String get wrongPasswordErrorMsg;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @passwordUpdatedSuccessMsg.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully!'**
  String get passwordUpdatedSuccessMsg;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailHintText.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHintText;

  /// No description provided for @doHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get doHaveAnAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileTitle;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @updateProfile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfile;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileUpdated;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @signupAsUser.
  ///
  /// In en, this message translates to:
  /// **'Sign up as User'**
  String get signupAsUser;

  /// No description provided for @signupAsShop.
  ///
  /// In en, this message translates to:
  /// **'Sign up as Shop'**
  String get signupAsShop;

  /// No description provided for @shopDescription.
  ///
  /// In en, this message translates to:
  /// **'Shop Description'**
  String get shopDescription;

  /// No description provided for @shopType.
  ///
  /// In en, this message translates to:
  /// **'Shop Type'**
  String get shopType;

  /// No description provided for @shopTypeRepairer.
  ///
  /// In en, this message translates to:
  /// **'Repairer'**
  String get shopTypeRepairer;

  /// No description provided for @shopTypeSeller.
  ///
  /// In en, this message translates to:
  /// **'Seller'**
  String get shopTypeSeller;

  /// No description provided for @shopTypeBoth.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get shopTypeBoth;

  /// No description provided for @shopAddressState.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get shopAddressState;

  /// No description provided for @shopAddressCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get shopAddressCity;

  /// No description provided for @shopAddressStreet.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get shopAddressStreet;

  /// No description provided for @shopAddressBuilding.
  ///
  /// In en, this message translates to:
  /// **'Building'**
  String get shopAddressBuilding;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get showMore;

  /// No description provided for @are_you_sure_delete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete offer?'**
  String get are_you_sure_delete;

  /// No description provided for @subs.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get subs;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @joinUsTitle.
  ///
  /// In en, this message translates to:
  /// **'Join Us'**
  String get joinUsTitle;

  /// No description provided for @joinUsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your role to get started'**
  String get joinUsSubtitle;

  /// No description provided for @driverTitle.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get driverTitle;

  /// No description provided for @driverSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Deliver orders and earn money'**
  String get driverSubtitle;

  /// No description provided for @userTitle.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userTitle;

  /// No description provided for @userSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Order and receive deliveries'**
  String get userSubtitle;

  /// No description provided for @shopTitle.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shopTitle;

  /// No description provided for @shopSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your store and products'**
  String get shopSubtitle;

  /// No description provided for @assignerTitle.
  ///
  /// In en, this message translates to:
  /// **'Assigner'**
  String get assignerTitle;

  /// No description provided for @assignerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Coordinate and assign deliveries'**
  String get assignerSubtitle;

  /// No description provided for @department.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get department;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @admin_dashboard.
  ///
  /// In en, this message translates to:
  /// **'Admin Dashboard'**
  String get admin_dashboard;

  /// No description provided for @total_users.
  ///
  /// In en, this message translates to:
  /// **'Total Users'**
  String get total_users;

  /// No description provided for @total_shops.
  ///
  /// In en, this message translates to:
  /// **'Total Shops'**
  String get total_shops;

  /// No description provided for @repair_requests.
  ///
  /// In en, this message translates to:
  /// **'Repair Requests'**
  String get repair_requests;

  /// No description provided for @total_orders.
  ///
  /// In en, this message translates to:
  /// **'Total Orders'**
  String get total_orders;

  /// No description provided for @count.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get count;

  /// No description provided for @real_time_platform_insights.
  ///
  /// In en, this message translates to:
  /// **'Real-time platform insights'**
  String get real_time_platform_insights;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @shops.
  ///
  /// In en, this message translates to:
  /// **'Shops'**
  String get shops;

  /// No description provided for @user_management.
  ///
  /// In en, this message translates to:
  /// **'User Management'**
  String get user_management;

  /// No description provided for @manage_user_accounts_roles_status.
  ///
  /// In en, this message translates to:
  /// **'Manage user accounts, roles, and status'**
  String get manage_user_accounts_roles_status;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @search_by_name_or_email.
  ///
  /// In en, this message translates to:
  /// **'Search by name or email...'**
  String get search_by_name_or_email;

  /// No description provided for @user_details.
  ///
  /// In en, this message translates to:
  /// **'User Details'**
  String get user_details;

  /// No description provided for @user_info.
  ///
  /// In en, this message translates to:
  /// **'User Info'**
  String get user_info;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get id;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @role_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Role updated successfully'**
  String get role_updated_successfully;

  /// No description provided for @role_update_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update role'**
  String get role_update_failed;

  /// No description provided for @user_deactivated_successfully.
  ///
  /// In en, this message translates to:
  /// **'User deactivated successfully'**
  String get user_deactivated_successfully;

  /// No description provided for @user_activated_successfully.
  ///
  /// In en, this message translates to:
  /// **'User activated successfully'**
  String get user_activated_successfully;

  /// No description provided for @user_status_update_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update user status'**
  String get user_status_update_failed;

  /// No description provided for @delete_user.
  ///
  /// In en, this message translates to:
  /// **'Delete User?'**
  String get delete_user;

  /// No description provided for @delete_user_warning.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone!'**
  String get delete_user_warning;

  /// No description provided for @yes_delete.
  ///
  /// In en, this message translates to:
  /// **'Yes, delete'**
  String get yes_delete;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @manage_product_categories.
  ///
  /// In en, this message translates to:
  /// **'Manage product categories'**
  String get manage_product_categories;

  /// No description provided for @total_categories.
  ///
  /// In en, this message translates to:
  /// **'Total Categories'**
  String get total_categories;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @search_by_name.
  ///
  /// In en, this message translates to:
  /// **'Search by name...'**
  String get search_by_name;

  /// No description provided for @add_category.
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get add_category;

  /// No description provided for @no_categories_available.
  ///
  /// In en, this message translates to:
  /// **'No categories available'**
  String get no_categories_available;

  /// No description provided for @category_details.
  ///
  /// In en, this message translates to:
  /// **'Category Details'**
  String get category_details;

  /// No description provided for @enter_category_name.
  ///
  /// In en, this message translates to:
  /// **'Enter category name'**
  String get enter_category_name;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @edit_category.
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get edit_category;

  /// No description provided for @delete_category.
  ///
  /// In en, this message translates to:
  /// **'Delete Category?'**
  String get delete_category;

  /// No description provided for @delete_category_warning.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone!'**
  String get delete_category_warning;

  /// No description provided for @id_copied_to_clipboard.
  ///
  /// In en, this message translates to:
  /// **'ID copied to clipboard'**
  String get id_copied_to_clipboard;

  /// No description provided for @category_added_successfully.
  ///
  /// In en, this message translates to:
  /// **'Category added successfully'**
  String get category_added_successfully;

  /// No description provided for @category_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Category updated successfully'**
  String get category_updated_successfully;

  /// No description provided for @category_deleted_successfully.
  ///
  /// In en, this message translates to:
  /// **'Category deleted successfully'**
  String get category_deleted_successfully;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
