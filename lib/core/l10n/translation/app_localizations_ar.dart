// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get app_name => 'Tech & Restore';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get repair => ' قائمه التصليح';

  @override
  String get devices => 'الاجهزة';

  @override
  String get orders => 'الطلبات';

  @override
  String get invoices => 'الفواتير';

  @override
  String get inventory => 'جرد';

  @override
  String get offers => 'العروض';

  @override
  String get support => 'الدعم';

  @override
  String get today_sales => 'مبيعات اليوم';

  @override
  String get new_orders => 'طلبات جديدة';

  @override
  String get reply_notifications => 'اشعارات الرد';

  @override
  String get customer_satisfaction => 'رضا العملاء';

  @override
  String get latest_orders => 'أحدث الطلبات';

  @override
  String get order_code => 'كود الطلب';

  @override
  String get customer => 'العميل';

  @override
  String get total => 'الإجمالي';

  @override
  String get order_status => 'حالة الطلب';

  @override
  String get order_details => 'تفاصيل الطلب';

  @override
  String get completed => 'مكتمل';

  @override
  String get processing => 'قيد المعالجة';

  @override
  String get shipped => 'تم الشحن';

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get inventory_alerts => 'اشعارات الجرد';

  @override
  String get low_stock => 'الكمية ستنتهي قريباً';

  @override
  String get samsung_screen => 'A16 شاشة سامسونج';

  @override
  String get samsung_charger => 'A16 شاحن سامسونج';

  @override
  String get devices_management => 'إدارة الأجهزة';

  @override
  String get devices_management_desc => 'يمكنك وصف جهازك هنا...';

  @override
  String get add_device => 'إضافة جهاز';

  @override
  String get device_types => 'أنواع الأجهزة';

  @override
  String get search_hint => 'ابحث باسم الجهاز، نوع الجهاز، الرقم التسلسلي...';

  @override
  String get device_status => 'حالة الجهاز';

  @override
  String get all_types => 'كل الأنواع';

  @override
  String get device_name => 'اسم الجهاز';

  @override
  String get device_type => 'نوع الجهاز';

  @override
  String get serial_number => 'الرقم التسلسلي';

  @override
  String get price => 'السعر';

  @override
  String get quantity => 'الكمية';

  @override
  String get status => 'حالة الجهاز';

  @override
  String get actions => 'تعديل / إزالة';

  @override
  String get newDev => 'جديد';

  @override
  String get used => 'مستعمل';

  @override
  String get edit => 'تعديل';

  @override
  String get delete => 'حذف';

  @override
  String get repair_requests_title => 'طلبات التصليح';

  @override
  String get repair_requests_subtitle => 'يمكنك رؤية جميع طلبات التصليح الخاصة بالعملاء و قبولها و تعديل حالة الطلب من هنا';

  @override
  String get status_filter => 'حالة الطلب';

  @override
  String get status_received => 'تم الاستلام';

  @override
  String get status_in_progress => 'قيد التنفيذ';

  @override
  String get status_completed => 'مكتمل';

  @override
  String get table_client => 'العميل';

  @override
  String get table_device => 'الجهاز';

  @override
  String get table_issue => 'العطل';

  @override
  String get table_status => 'حالة الطلب';

  @override
  String get table_date => 'التاريخ';

  @override
  String get table_action => 'اتخاذ قرار';

  @override
  String get orders_title => 'طلبات الشراء';

  @override
  String get orders_subtitle => 'يمكنك متابعة عمليات الشراء التي قام بها العميل من هنا';

  @override
  String get last_orders => 'آخر الطلبات';

  @override
  String get order => 'الطلب';

  @override
  String get customer_info => 'معلومات العميل';

  @override
  String get payment_details => 'تفاصيل الدفع';

  @override
  String get payment_method => 'طريقة الدفع';

  @override
  String get order_items => 'محتوى الطلب';

  @override
  String get product => 'المنتج';

  @override
  String get track_order => 'تتبع الطلب';

  @override
  String get order_placed => 'تم الطلب';

  @override
  String get delivered => 'تم التوصيل';

  @override
  String get egp => 'جنيه';

  @override
  String get transactions_title => 'الدخل والإيرادات';

  @override
  String get transactions => 'العمليات';

  @override
  String get transactions_subtitle => 'يمكنك رؤية الدخل الشهري أو السنوي لطلبات التصليح والمبيعات من هنا';

  @override
  String get month => 'الشهر';

  @override
  String get january => 'يناير';

  @override
  String get february => 'فبراير';

  @override
  String get march => 'مارس';

  @override
  String get april => 'أبريل';

  @override
  String get may => 'مايو';

  @override
  String get search_hint_shop => 'ابحث عن محلات الصيانة...';

  @override
  String get total_profits => 'إجمالي الأرباح';

  @override
  String repairs_percent(Object percent) {
    return 'تصليح (%$percent)';
  }

  @override
  String sales_percent(Object percent) {
    return 'مبيعات (%$percent)';
  }

  @override
  String get date => 'التاريخ';

  @override
  String get service_type => 'نوع الخدمة';

  @override
  String get device => 'الجهاز';

  @override
  String get shop => 'المكان';

  @override
  String get amount => 'المبلغ';

  @override
  String get out_for_delivery => 'قيد التوصيل';

  @override
  String get failed => 'فشل';

  @override
  String get inventory_title => 'نظام الجرد';

  @override
  String get inventory_description => 'يمكنك متابعة عدد الأجهزة ورؤية إن كان هناك نقص في منتج ما من هنا';

  @override
  String get inventory_search => 'ابحث في الجرد...';

  @override
  String get inventory_add_product => 'إضافة منتج';

  @override
  String get inventory_add_csv => 'إضافة CSV';

  @override
  String get inventory_export_csv => 'تصدير CSV';

  @override
  String get inventory_product_name => 'اسم المنتج';

  @override
  String get inventory_category => 'التصنيف';

  @override
  String get inventory_price => 'السعر';

  @override
  String get inventory_quantity => 'الكمية';

  @override
  String get inventory_status => 'حالة المنتج';

  @override
  String get inventory_action => 'اتخاذ قرار';

  @override
  String get inventory_total_products => 'عدد المنتجات';

  @override
  String get inventory_low_stock => 'منتجات الكميات القليلة';

  @override
  String get inventory_total_price => 'إجمالي سعر المنتجات';

  @override
  String get inventory_currency => 'جنيه';

  @override
  String get inventory_edit => 'تعديل';

  @override
  String get inventory_delete => 'حذف';

  @override
  String get offersTitle => 'العروض';

  @override
  String get offersSubtitle => 'يمكنك إضافة وإدارة العروض والخصومات';

  @override
  String get searchOffers => 'ابحث في العروض...';

  @override
  String get addNewOffer => 'عرض جديد';

  @override
  String get offerColumnTitle => 'العرض';

  @override
  String get offerColumnContent => 'وصف العرض';

  @override
  String get offerColumnDiscount => 'الخصم %';

  @override
  String get offerColumnDuration => 'مدة العرض';

  @override
  String get offerColumnStatus => 'حالة العرض';

  @override
  String get offerColumnActions => 'اتخاذ قرار';

  @override
  String get ofShow => 'من';

  @override
  String get toShow => 'الي';

  @override
  String get supportTitle => 'الدعم';

  @override
  String get supportSubtitle => 'يمكنك الاطلاع على جميع مشاكل واستفسارات العميل من هنا';

  @override
  String get searchSupport => 'ابحث في طلبات الدعم...';

  @override
  String get allStatus => 'كل الحالات';

  @override
  String get openStatus => 'مفتوح';

  @override
  String get inProgressStatus => 'قيد التنفيذ';

  @override
  String get resolvedStatus => 'تم الحل';

  @override
  String get tableRequestId => 'رقم الطلب';

  @override
  String get tableCustomer => 'العميل';

  @override
  String get tableContent => 'محتوى الطلب';

  @override
  String get tablePriority => 'حجم المشكلة';

  @override
  String get tableStatus => 'حالة الطلب';

  @override
  String get tableLastUpdate => 'آخر تحديث للطلب';

  @override
  String get tableActions => 'اتخاذ قرار';

  @override
  String get requestsCount => 'طلبات';

  @override
  String get welcome => 'مرحبًا بك في تك ريستور!';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get home => 'الصفحة الرئيسية';

  @override
  String get deviceIssue => 'مشكلة في الجهاز';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get liveStu => 'تحديثات الحالة المباشرة';

  @override
  String get trackingNumber => 'رقم التتبع';

  @override
  String get repairStatue => 'حالة الإصلاح';

  @override
  String get start => 'لنبدأ';

  @override
  String get name => 'الاسم الكامل';

  @override
  String get uploadPorV => 'تحميل الصور أو مقاطع الفيديو';

  @override
  String get describeIssue => 'صف المشكلة';

  @override
  String get deviceIssueQuote => 'ما هي المشكلة في جهازك؟';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get phone => 'رقم الهاتف';

  @override
  String get signup => 'إنشاء حساب';

  @override
  String get welcomeBack => 'مرحبًا بعودتك';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get addPhoto => 'إضافة صورة';

  @override
  String get email => 'عنوان البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get forgetPassword => 'نسيت كلمة المرور؟';

  @override
  String get withGoogle => 'المتابعة باستخدام Google';

  @override
  String get newOrder => 'طلب جديد';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get whatRepair => 'ما الذي تريد إصلاحه؟';

  @override
  String get newUser => 'مستخدم جديد';

  @override
  String get signUpQuote => 'احصل على إصلاح لجهازك بسرعة.';

  @override
  String get secSignUpQuote => 'سنوصلك بأفضل محلات الصيانة المحلية لإصلاح جهازك.';

  @override
  String get byContinuing => 'بالمتابعة، فإنك توافق على شروط الاستخدام. اقرأ سياسة الخصوصية الخاصة بنا.';

  @override
  String get startQuote => 'حلّك الشامل لجميع مشاكل التقنية! من الشاشات المكسورة إلى الحواسيب البطيئة، سنوصلك بخدمات إصلاح موثوقة. دعنا نعيد أجهزتك إلى حالتها الممتازة! اضغط للبدء.';

  @override
  String get explore => 'تصفح';

  @override
  String get next => 'التالي';

  @override
  String get cancel => 'إلغاء';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'الاسم الأخير';

  @override
  String get loginSuccessMsg => 'تم تسجيل الدخول بنجاح';

  @override
  String get loading => 'نحميل...';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get are_you_sure_logout => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get currentPassword => 'كلمة المرور الحالية';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get invalidPasswordMsg => 'كلمة المرور غير صالحة';

  @override
  String get passwordErrorMatchingMsg => 'كلمات المرور غير متطابقة!';

  @override
  String get updateText => 'تحديث';

  @override
  String get logoutAlertMsg => 'تسجيل الخروج';

  @override
  String get logoutConfirmTextCenter => 'تأكيد تسجيل الخروج!';

  @override
  String get resetPasswordUnderMsg => 'يجب ألا تكون كلمة المرور فارغة ويجب أن تحتوي على 6 أحرف على الأقل مع حرف كبير ورقم واحد على الأقل';

  @override
  String get emailVerificationScreen => 'التحقق من البريد الإلكتروني';

  @override
  String get emailVerificationScreenUnderMsg => 'يرجى إدخال الرمز الذي تم إرساله إلى\nعنوان بريدك الإلكتروني';

  @override
  String get codeReceiveMsgError => 'لم تستلم الرمز؟';

  @override
  String get forgetPasswordUnderText => 'يرجى إدخال البريد الإلكتروني المرتبط\nبحسابك';

  @override
  String get validationEmailErrorMessage => 'هذا البريد الإلكتروني غير صالح';

  @override
  String get requiredEmailErrorMessage => 'البريد الإلكتروني مطلوب';

  @override
  String get continueButton => 'متابعة';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get newPasswordLabel => 'كلمة المرور الجديدة';

  @override
  String get newPasswordHint => 'أدخل كلمة المرور الجديدة';

  @override
  String get wrongPasswordErrorMsg => 'كلمة المرور غير صحيحة، حاول مرة أخرى';

  @override
  String get nextButton => 'التالي';

  @override
  String get resend => 'إعادة إرسال';

  @override
  String get passwordUpdatedSuccessMsg => 'تم تغير كلمة المرور بنجاح!';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get emailHintText => 'أدخل بريدك الإلكتروني';

  @override
  String get doHaveAnAccount => 'ليس لديك حساب؟';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get editProfileTitle => 'تعديل الملف الشخصي';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get updateProfile => 'تحديث الملف الشخصي';

  @override
  String get profileUpdated => 'تم تحديث الملف الشخصي بنجاح!';

  @override
  String get error => 'خطأ';

  @override
  String get signupAsUser => 'تسجيل كمستخدم';

  @override
  String get signupAsShop => 'تسجيل كمتجر';

  @override
  String get shopDescription => 'وصف المتجر';

  @override
  String get shopType => 'نوع المتجر';

  @override
  String get shopTypeRepairer => 'مصلح';

  @override
  String get shopTypeSeller => 'بائع';

  @override
  String get shopTypeBoth => 'الاثنان معاً';

  @override
  String get shopAddressState => 'المحافظة';

  @override
  String get shopAddressCity => 'المدينة';

  @override
  String get shopAddressStreet => 'الشارع';

  @override
  String get shopAddressBuilding => 'المبنى';

  @override
  String get save => 'حفظ';

  @override
  String get showMore => 'عرض المزيد';

  @override
  String get are_you_sure_delete => 'هل أنت متأكد أنك تريد حذف العرض؟';

  @override
  String get subs => 'الاشتراك';

  @override
  String get rememberMe => 'تذكرني';

  @override
  String get joinUsTitle => 'انضم إلينا';

  @override
  String get joinUsSubtitle => 'اختر دورك للبدء';

  @override
  String get driverTitle => 'سائق';

  @override
  String get driverSubtitle => 'قم بتوصيل الطلبات واربح المال';

  @override
  String get userTitle => 'مستخدم';

  @override
  String get userSubtitle => 'اطلب واستقبل التوصيلات';

  @override
  String get shopTitle => 'متجر';

  @override
  String get shopSubtitle => 'إدارة متجرك ومنتجاتك';

  @override
  String get assignerTitle => 'مُنسّق';

  @override
  String get assignerSubtitle => 'تنسيق وتعيين عمليات التوصيل';

  @override
  String get department => 'القسم';

  @override
  String get address => 'العنوان';
}
