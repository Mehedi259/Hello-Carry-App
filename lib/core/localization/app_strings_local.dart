class AppLocal {
  static bool isBn(String lang) => lang == 'বাংলা' || lang.toLowerCase() == 'bn';

  static String t(String key, String lang) {
    final bn = isBn(lang);
    if (!bn) {
      return _en[key] ?? key;
    }
    return _bn[key] ?? _en[key] ?? key;
  }

  static const Map<String, String> _en = {
    // App Branding
    'appName': 'Hello Carry',
    'appTagline': 'Your Cargo, Our Priority',
    'companySisterConcern': 'Sister concern of Hello Probash',
    'developedBy': 'Developed by Hello Probash Tech',

    // Onboarding
    'onboardingTitle1': 'Fast Cargo Between BD & Oman',
    'onboardingSub1': 'Direct air cargo in 3-5 days and economic sea freight connecting Dhaka, Chittagong and Muscat.',
    'onboardingTitle2': 'Product Sourcing & Wholesale',
    'onboardingSub2': 'Source genuine electronics, RMG export garments, and lifestyle products directly from Bangladesh & GCC.',
    'onboardingTitle3': 'Real-Time Tracking & Insurance',
    'onboardingSub3': 'Track every milestone from pickup to doorstep with 100% verified cargo insurance coverage.',
    'selectLanguage': 'Select Preferred Language',
    'selectLanguageSub': 'Choose your app language to get started',
    'getStarted': 'Get Started',
    'next': 'Next',
    'skip': 'Skip',
    'continueText': 'Continue',

    // Navigation
    'navHome': 'Home',
    'navTrack': 'Track',
    'navProducts': 'Products',
    'navShipments': 'Shipments',
    'navProfile': 'Profile',

    // Hero
    'heroTitle': 'Ship Smarter\nBetween Bangladesh\n& Oman',
    'heroSubtitle': 'Your trusted cargo partner for air express & sea freight shipments.',
    'directBadge': 'Direct BD - Oman Cargo Service',
    'bangladesh': 'Bangladesh',
    'oman': 'Oman',

    // Quick Tracker
    'trackCargo': 'Track Your Cargo',
    'trackCargoSub': 'Enter tracking number to get real-time status',
    'trackNow': 'Track Now',
    'trackingInputHint': 'e.g. #HC123456',
    'recent': 'Recent: ',

    // Quick Actions
    'sourcingTitle': 'Sourcing\nProducts',
    'sourcingSub': 'View All',
    'shipmentsTitle': 'My\nShipments',
    'shipmentsSub': 'Live Tracking',
    'quoteTitle': 'Get a\nQuote',
    'quoteSub': 'Easy & Fast',
    'supportTitle': 'Customer\nSupport',
    'supportSub': "We're Here",

    // Active Shipment
    'activeShipment': 'Active Shipment',
    'activeShipmentSub': 'Real-time status of your cargo',
    'viewAll': 'View All',
    'eta': 'ETA',

    // Sourcing Section
    'sourcingProducts': 'Sourcing Products',
    'sourcingProductsSub': 'Explore popular products you can source & ship',
    'available': 'Available',
    'availableForSourcing': 'Available for Sourcing',
    'description': 'Description',
    'keyFeatures': 'Key Features',
    'doorDeliveryAvailable': 'Door-to-Door Delivery Available',
    'estimatedAir': 'Estimated Air Shipping to Oman: 3-5 business days',
    'requestQuoteForProduct': 'Request Sourcing & Shipping Quote',

    // Trust Card
    'securityGuarantee': 'Hello Carry Security Guarantee',
    'securityGuaranteeSub': '100% cargo insurance & full customs clearance support',
    'airSpeed': 'Air: 3-5 Days',
    'seaCost': 'Sea: Low Cost',
    'doorDelivery': 'Door Delivery',

    // Tracking Screen
    'liveHubRadar': 'Live Hub Radar',
    'trackingNumber': 'Tracking Number',
    'howItWorks': 'How It Works?',
    'step1': 'Enter\nTracking Number',
    'step2': 'Check\nCurrent Status',
    'step3': 'Get\nLatest Updates',
    'safeHands': 'Your cargo is in safe hands',
    'safeHandsSub': 'We ensure secure and reliable delivery from Bangladesh to Oman with verified customs documentation.',
    'viewFullTimeline': 'View Full Timeline & Details',

    // Shipment Details
    'shipmentDetails': 'Shipment Details',
    'latestLiveUpdate': 'Latest Live Update',
    'shipmentInfo': 'Shipment Information',
    'trackingTimeline': 'Tracking Journey Timeline',
    'routeAddressDetails': 'Route & Address Details',
    'senderBD': 'Sender (Bangladesh)',
    'receiverOM': 'Receiver (Oman)',
    'downloadWaybill': 'Download Waybill',
    'contactSupport': 'Contact Support',
    'productType': 'Product Type',
    'weight': 'Weight',
    'shippingMethod': 'Shipping Method',
    'estimatedDelivery': 'Estimated Delivery',
    'createdDate': 'Created Date',

    // Statuses
    'inTransit': 'In Transit',
    'delivered': 'Delivered',
    'processing': 'Processing',
    'pickedUp': 'Picked Up',
    'cancelled': 'Cancelled',

    // Quote Screen
    'getQuote': 'Get a Quote',
    'getQuoteTitle': 'Get a Quote for Your Shipment',
    'getQuoteSub': "Tell us what you want to ship and we'll calculate the best rate.",
    'productCategory': 'Product Category',
    'productDesc': 'Product Description (Optional)',
    'descHint': 'Describe items, brand, fragile requirements...',
    'estimatedWeight': 'Estimated Weight',
    'airCargoExpress': 'Air Cargo Express',
    'seaFreightEconomy': 'Sea Freight Economy',
    'speedAir': '3 - 5 Days',
    'speedSea': '15 - 20 Days',
    'pickupRoute': 'Pickup & Destination Route',
    'estimatedTotalRate': 'Estimated Total Rate',
    'submitRequest': 'Submit Request',
    'quoteSubmittedTitle': 'Quote Request Submitted!',
    'referenceId': 'Reference ID',
    'backToHome': 'Back to Home',
    'route': 'Route',
    'category': 'Category',
    'method': 'Method',
    'estimatedRate': 'Estimated Rate',

    // Shipments Screen
    'myShipments': 'My Shipments',
    'noShipments': 'No Shipments Found',
    'noShipmentsSub': 'Your cargo shipments will appear here once booked',

    // Notifications Screen
    'notifications': 'Notifications',
    'markAllRead': 'Mark all read',
    'noNotifications': 'No Notifications',
    'noNotificationsSub': "You're all caught up with your cargo updates!",

    // Profile Screen
    'profile': 'Profile',
    'totalShipments': 'Total Shipments',
    'personalInfo': 'Personal Information',
    'personalInfoSub': 'Full name, phone, NID & passport',
    'shippingAddresses': 'Shipping Addresses',
    'shippingAddressesSub': 'Saved delivery points in BD & Oman',
    'paymentMethods': 'Payment Methods',
    'paymentMethodsSub': 'Cards, bKash, Bank Muscat, Thawani',
    'currencyPreference': 'Currency Preference',
    'language': 'Language / ভাষা',
    'helpSupport': 'Help & Support',
    'helpSupportSub': 'FAQs, chat, and hotline',
    'termsConditions': 'Terms & Conditions',
    'termsConditionsSub': 'Cargo policy, insurance guidelines',
    'logOut': 'Log Out',
    'logOutSub': 'Sign out of current device session',
  };

  static const Map<String, String> _bn = {
    // App Branding
    'appName': 'হ্যালো ক্যারি',
    'appTagline': 'আপনার কার্গো, আমাদের অগ্রাধিকার',
    'companySisterConcern': 'হ্যালো প্রবাস-এর সহযোগী প্রতিষ্ঠান',
    'developedBy': 'হ্যালো প্রবাস টেক কর্তৃক নির্মিত',

    // Onboarding
    'onboardingTitle1': 'বাংলাদেশ ও ওমানের দ্রুততম কার্গো',
    'onboardingSub1': 'ঢাকা, চট্টগ্রাম ও মাস্কাটের মধ্যে সরাসরি ৩-৫ দিনে এয়ার কার্গো এবং সাশ্রয়ী সি ফ্রেইট ডেলিভারি।',
    'onboardingTitle2': 'পাইকারি মূল্যে পণ্য সোর্সিং',
    'onboardingSub2': 'বাংলাদেশ ও জিসিসি থেকে সরাসরি অথেন্টিক গ্যাজেটস, এক্সপোর্ট গার্মেন্টস ও দরকারি পণ্য সংগ্রহ করুন।',
    'onboardingTitle3': 'লাইভ ট্র্যাকিং ও ১০০% বীমা সুবিধা',
    'onboardingSub3': 'হাব থেকে আপনার দোরগোড়া পর্যন্ত প্রতিটি ধাপ লাইভ ট্র্যাক করুন সম্পূর্ণ ইনস্যুরেন্স ও কাস্টমস সুবিধায়।',
    'selectLanguage': 'পছন্দের ভাষা নির্বাচন করুন',
    'selectLanguageSub': 'অ্যাপ শুরু করতে আপনার পছন্দের ভাষা বেছে নিন',
    'getStarted': 'শুরু করুন',
    'next': 'পরবর্তী',
    'skip': 'স্কিপ',
    'continueText': 'চালিয়ে যান',

    // Navigation
    'navHome': 'হোম',
    'navTrack': 'ট্র্যাকিং',
    'navProducts': 'পণ্যসমূহ',
    'navShipments': 'শিপমেন্ট',
    'navProfile': 'প্রোফাইল',

    // Hero
    'heroTitle': 'বাংলাদেশ ও ওমানের মধ্যে\nসেরা ও দ্রুততম\nকার্গো সার্ভিস',
    'heroSubtitle': 'এয়ার এক্সপ্রেস ও সি ফ্রেইট পণ্য পরিবহনে আপনার বিশ্বস্ত ও নির্ভরযোগ্য কার্গো পার্টনার।',
    'directBadge': 'সরাসরি বিডি - ওমান কার্গো সার্ভিস',
    'bangladesh': 'বাংলাদেশ',
    'oman': 'ওমান',

    // Quick Tracker
    'trackCargo': 'আপনার কার্গো ট্র্যাক করুন',
    'trackCargoSub': 'রিয়েল-টাইম তথ্য জানতে ট্র্যাকিং নম্বর লিখুন',
    'trackNow': 'ট্র্যাক করুন',
    'trackingInputHint': 'যেমন: #HC123456',
    'recent': 'সাম্প্রতিক: ',

    // Quick Actions
    'sourcingTitle': 'পণ্য\nসোর্সিং',
    'sourcingSub': 'সব দেখুন',
    'shipmentsTitle': 'আমার\nশিপমেন্ট',
    'shipmentsSub': 'লাইভ ট্র্যাকিং',
    'quoteTitle': 'কোটেশন\nনিন',
    'quoteSub': 'সহজ ও দ্রুত',
    'supportTitle': 'গ্রাহক\nসেবা',
    'supportSub': 'আমরা আছি',

    // Active Shipment
    'activeShipment': 'সক্রিয় শিপমেন্ট',
    'activeShipmentSub': 'আপনার কার্গোর লাইভ অবস্থান',
    'viewAll': 'সব দেখুন',
    'eta': 'ডেলিভারি',

    // Sourcing Section
    'sourcingProducts': 'সোর্সিং পণ্যসম্ভার',
    'sourcingProductsSub': 'জনপ্রিয় পণ্যসমূহ সোর্সিং ও ডেলিভারি করুন',
    'available': 'উপলব্ধ',
    'availableForSourcing': 'সোর্সিংয়ের জন্য প্রস্তুত',
    'description': 'পণ্যের বিবরণ',
    'keyFeatures': 'প্রধান বৈশিষ্ট্যসমূহ',
    'doorDeliveryAvailable': 'হোম ডেলিভারি সুবিধা উপলব্ধ',
    'estimatedAir': 'ওমানে আনুমানিক এয়ার শিপিং: ৩-৫ কার্যদিবস',
    'requestQuoteForProduct': 'সোর্সিং ও শিপিং কোটেশন পাঠান',

    // Trust Card
    'securityGuarantee': 'হ্যালো ক্যারি নিরাপত্তা নিশ্চয়তা',
    'securityGuaranteeSub': '১০০% পণ্য বীমা ও সম্পূর্ণ কাস্টমস সহায়তা',
    'airSpeed': 'এয়ার: ৩-৫ দিন',
    'seaCost': 'সি: সাশ্রয়ী খরচ',
    'doorDelivery': 'হোম ডেলিভারি',

    // Tracking Screen
    'liveHubRadar': 'লাইভ হাব রাডার',
    'trackingNumber': 'ট্র্যাকিং নম্বর',
    'howItWorks': 'কীভাবে কাজ করে?',
    'step1': 'ট্র্যাকিং নম্বর\nদিন',
    'step2': 'বর্তমান অবস্থা\nদেখুন',
    'step3': 'সর্বশেষ আপডেট\nপান',
    'safeHands': 'আপনার পণ্য সম্পূর্ণ নিরাপদ',
    'safeHandsSub': 'আমরা সঠিক ডকুমেন্টস ও সম্পূর্ণ কাস্টমস সুবিধাসহ নিরাপদে পণ্য পৌঁছে দেই।',
    'viewFullTimeline': 'সম্পূর্ণ টাইমলাইন ও বিবরণ দেখুন',

    // Shipment Details
    'shipmentDetails': 'শিপমেন্টের বিস্তারিত',
    'latestLiveUpdate': 'সর্বশেষ লাইভ আপডেট',
    'shipmentInfo': 'শিপমেন্টের তথ্য',
    'trackingTimeline': 'ট্র্যাকিং টাইমলাইন',
    'routeAddressDetails': 'রুট ও ঠিকানার বিবরণ',
    'senderBD': 'প্রেরক (বাংলাদেশ)',
    'receiverOM': 'প্রাপক (ওমান)',
    'downloadWaybill': 'ওয়েবিল ডাউনলোড',
    'contactSupport': 'সাপোর্টে কথা বলুন',
    'productType': 'পণ্যের ধরন',
    'weight': 'ওজন',
    'shippingMethod': 'শিপিং পদ্ধতি',
    'estimatedDelivery': 'আনুমানিক ডেলিভারি',
    'createdDate': 'তৈরির তারিখ',

    // Statuses
    'inTransit': 'ট্রানজিটে আছে',
    'delivered': 'ডেলিভার্ড',
    'processing': 'প্রক্রিয়াধীন',
    'pickedUp': 'পিকড আপ',
    'cancelled': 'বাতিল',

    // Quote Screen
    'getQuote': 'কোটেশন রিকোয়েস্ট',
    'getQuoteTitle': 'আপনার চালানের জন্য কোটেশন নিন',
    'getQuoteSub': 'কী পাঠাতে চান জানান, আমরা সেরা রেট দেব।',
    'productCategory': 'পণ্যের ক্যাটাগরি',
    'productDesc': 'পণ্যের বিবরণ (ঐচ্ছিক)',
    'descHint': 'পণ্যের নাম, ব্র্যান্ড, ভঙ্গুর কিনা বিস্তারিত লিখুন...',
    'estimatedWeight': 'আনুমানিক ওজন',
    'airCargoExpress': 'এয়ার কার্গো এক্সপ্রেস',
    'seaFreightEconomy': 'সি ফ্রেইট ইকোনমি',
    'speedAir': '৩ - ৫ দিন',
    'speedSea': '১৫ - ২০ দিন',
    'pickupRoute': 'পিকআপ ও গন্তব্য রুট',
    'estimatedTotalRate': 'আনুমানিক মোট রেট',
    'submitRequest': 'অনুরোধ জমা দিন',
    'quoteSubmittedTitle': 'কোটেশন অনুরোধ জমা হয়েছে!',
    'referenceId': 'রেফারেন্স আইডি',
    'backToHome': 'হোমে ফিরে যান',
    'route': 'রুট',
    'category': 'ক্যাটাগরি',
    'method': 'পদ্ধতি',
    'estimatedRate': 'আনুমানিক রেট',

    // Shipments Screen
    'myShipments': 'আমার শিপমেন্ট',
    'noShipments': 'কোনো শিপমেন্ট পাওয়া যায়নি',
    'noShipmentsSub': 'কার্গো বুকিং সম্পন্ন হলে আপনার শিপমেন্ট এখানে দেখাবে',

    // Notifications Screen
    'notifications': 'নোটিফিকেশন',
    'markAllRead': 'সব পঠিত করুন',
    'noNotifications': 'কোনো নোটিফিকেশন নেই',
    'noNotificationsSub': 'আপনার সকল কার্গো আপডেট সম্পন্ন!',

    // Profile Screen
    'profile': 'প্রোফাইল',
    'totalShipments': 'মোট শিপমেন্ট',
    'personalInfo': 'ব্যক্তিগত তথ্য',
    'personalInfoSub': 'পুরো নাম, ফোন, এনআইডি ও পাসপোর্ট',
    'shippingAddresses': 'শিপিং ঠিকানা',
    'shippingAddressesSub': 'বাংলাদেশ ও ওমানের সংরক্ষিত ডেলিভারি ঠিকানা',
    'paymentMethods': 'পেমেন্ট মাধ্যম',
    'paymentMethodsSub': 'কার্ড, বিকাশ, ব্যাংক মাস্কাট, থাওয়ানি',
    'currencyPreference': 'মুদ্রা পছন্দ',
    'language': 'ভাষা (Language)',
    'helpSupport': 'সাহায্য ও সাপোর্ট',
    'helpSupportSub': 'সাধারণ প্রশ্ন, চ্যাট ও ২৪/৭ হেল্পলাইন',
    'termsConditions': 'শর্তাবলী ও নীতিমালা',
    'termsConditionsSub': 'কার্গো পলিসি ও ইন্স্যুরেন্স নির্দেশিকা',
    'logOut': 'লগ আউট',
    'logOutSub': 'ডিভাইস সেশন থেকে সাইন আউট করুন',
  };
}
