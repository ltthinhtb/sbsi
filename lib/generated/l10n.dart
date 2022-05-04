// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Settings`
  String get settings_title {
    return Intl.message(
      'Settings',
      name: 'settings_title',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get settings_themeMode {
    return Intl.message(
      'Theme',
      name: 'settings_themeMode',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get settings_themeModeSystem {
    return Intl.message(
      'System',
      name: 'settings_themeModeSystem',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get settings_themeModeLight {
    return Intl.message(
      'Light',
      name: 'settings_themeModeLight',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get settings_themeModeDark {
    return Intl.message(
      'Dark',
      name: 'settings_themeModeDark',
      desc: '',
      args: [],
    );
  }

  /// `Tiếng việt`
  String get settings_languageVietnamese {
    return Intl.message(
      'Tiếng việt',
      name: 'settings_languageVietnamese',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get settings_languageEnglish {
    return Intl.message(
      'English',
      name: 'settings_languageEnglish',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settings_language {
    return Intl.message(
      'Language',
      name: 'settings_language',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Login by FaceID`
  String get login_face_id {
    return Intl.message(
      'Login by FaceID',
      name: 'login_face_id',
      desc: '',
      args: [],
    );
  }

  /// `Free trading for life`
  String get splash_title1 {
    return Intl.message(
      'Free trading for life',
      name: 'splash_title1',
      desc: '',
      args: [],
    );
  }

  /// `Saving transaction with the cheapest fee in the market`
  String get splash_sub1 {
    return Intl.message(
      'Saving transaction with the cheapest fee in the market',
      name: 'splash_sub1',
      desc: '',
      args: [],
    );
  }

  /// `Choose a free beautiful number account`
  String get splash_title2 {
    return Intl.message(
      'Choose a free beautiful number account',
      name: 'splash_title2',
      desc: '',
      args: [],
    );
  }

  /// `Choose the account number you like`
  String get splash_sub2 {
    return Intl.message(
      'Choose the account number you like',
      name: 'splash_sub2',
      desc: '',
      args: [],
    );
  }

  /// `With only 3 minutes to open an account`
  String get splash_title3 {
    return Intl.message(
      'With only 3 minutes to open an account',
      name: 'splash_title3',
      desc: '',
      args: [],
    );
  }

  /// `Browse and have an account within 24 hours`
  String get splash_sub3 {
    return Intl.message(
      'Browse and have an account within 24 hours',
      name: 'splash_sub3',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get user_name {
    return Intl.message(
      'Username',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Old password`
  String get old_password {
    return Intl.message(
      'Old password',
      name: 'old_password',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get new_password {
    return Intl.message(
      'New password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get confirm_new_password {
    return Intl.message(
      'Confirm new password',
      name: 'confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Save password`
  String get save_password {
    return Intl.message(
      'Save password',
      name: 'save_password',
      desc: '',
      args: [],
    );
  }

  /// `Change password successfully`
  String get change_password_success {
    return Intl.message(
      'Change password successfully',
      name: 'change_password_success',
      desc: '',
      args: [],
    );
  }

  /// `Input username`
  String get please_input_user {
    return Intl.message(
      'Input username',
      name: 'please_input_user',
      desc: '',
      args: [],
    );
  }

  /// `Input password`
  String get please_input_password {
    return Intl.message(
      'Input password',
      name: 'please_input_password',
      desc: '',
      args: [],
    );
  }

  /// `Don't have account? `
  String get not_account {
    return Intl.message(
      'Don\'t have account? ',
      name: 'not_account',
      desc: '',
      args: [],
    );
  }

  /// `Have account`
  String get have_account {
    return Intl.message(
      'Have account',
      name: 'have_account',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_pass {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_pass',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Account is empty`
  String get empty_account {
    return Intl.message(
      'Account is empty',
      name: 'empty_account',
      desc: '',
      args: [],
    );
  }

  /// `Password is empty`
  String get empty_password {
    return Intl.message(
      'Password is empty',
      name: 'empty_password',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Network Error`
  String get network_error {
    return Intl.message(
      'Network Error',
      name: 'network_error',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Stock market`
  String get stock_market {
    return Intl.message(
      'Stock market',
      name: 'stock_market',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message(
      'Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Order note`
  String get order_note {
    return Intl.message(
      'Order note',
      name: 'order_note',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get category {
    return Intl.message(
      'Menu',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Assets`
  String get assets {
    return Intl.message(
      'Assets',
      name: 'assets',
      desc: '',
      args: [],
    );
  }

  /// `Profit`
  String get profit {
    return Intl.message(
      'Profit',
      name: 'profit',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Permission buy`
  String get permission_to_buy {
    return Intl.message(
      'Permission buy',
      name: 'permission_to_buy',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `Up to`
  String get up_to {
    return Intl.message(
      'Up to',
      name: 'up_to',
      desc: '',
      args: [],
    );
  }

  /// `Min volume`
  String get min_VOLUME {
    return Intl.message(
      'Min volume',
      name: 'min_VOLUME',
      desc: '',
      args: [],
    );
  }

  /// `Invest to`
  String get invest_to {
    return Intl.message(
      'Invest to',
      name: 'invest_to',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Invest`
  String get invest {
    return Intl.message(
      'Invest',
      name: 'invest',
      desc: '',
      args: [],
    );
  }

  /// `Invest Information`
  String get invest_information {
    return Intl.message(
      'Invest Information',
      name: 'invest_information',
      desc: '',
      args: [],
    );
  }

  /// `Invest money`
  String get invest_money {
    return Intl.message(
      'Invest money',
      name: 'invest_money',
      desc: '',
      args: [],
    );
  }

  /// `Input money`
  String get input_invest_money {
    return Intl.message(
      'Input money',
      name: 'input_invest_money',
      desc: '',
      args: [],
    );
  }

  /// `Invest time`
  String get invest_time {
    return Intl.message(
      'Invest time',
      name: 'invest_time',
      desc: '',
      args: [],
    );
  }

  /// `Months`
  String get month {
    return Intl.message(
      'Months',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Select Product`
  String get select_product {
    return Intl.message(
      'Select Product',
      name: 'select_product',
      desc: '',
      args: [],
    );
  }

  /// `Interest Expect`
  String get interest_expect {
    return Intl.message(
      'Interest Expect',
      name: 'interest_expect',
      desc: '',
      args: [],
    );
  }

  /// `Interest Money`
  String get interest_money {
    return Intl.message(
      'Interest Money',
      name: 'interest_money',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Interst TT`
  String get interest_tt {
    return Intl.message(
      'Interst TT',
      name: 'interest_tt',
      desc: '',
      args: [],
    );
  }

  /// `Interst ST`
  String get interest_st {
    return Intl.message(
      'Interst ST',
      name: 'interest_st',
      desc: '',
      args: [],
    );
  }

  /// `Receive money`
  String get receive_money {
    return Intl.message(
      'Receive money',
      name: 'receive_money',
      desc: '',
      args: [],
    );
  }

  /// `Coupon`
  String get coupon {
    return Intl.message(
      'Coupon',
      name: 'coupon',
      desc: '',
      args: [],
    );
  }

  /// `Interest now`
  String get interest_now {
    return Intl.message(
      'Interest now',
      name: 'interest_now',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Payment type`
  String get pay_type {
    return Intl.message(
      'Payment type',
      name: 'pay_type',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Payment`
  String get transfer_payment {
    return Intl.message(
      'Transfer Payment',
      name: 'transfer_payment',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Transfer information`
  String get transfer_information {
    return Intl.message(
      'Transfer information',
      name: 'transfer_information',
      desc: '',
      args: [],
    );
  }

  /// `Interest`
  String get interest {
    return Intl.message(
      'Interest',
      name: 'interest',
      desc: '',
      args: [],
    );
  }

  /// `year`
  String get year {
    return Intl.message(
      'year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Bond code`
  String get bond_code {
    return Intl.message(
      'Bond code',
      name: 'bond_code',
      desc: '',
      args: [],
    );
  }

  /// `Invest start`
  String get invest_start {
    return Intl.message(
      'Invest start',
      name: 'invest_start',
      desc: '',
      args: [],
    );
  }

  /// `Invest end`
  String get invest_end {
    return Intl.message(
      'Invest end',
      name: 'invest_end',
      desc: '',
      args: [],
    );
  }

  /// `Fee`
  String get fee {
    return Intl.message(
      'Fee',
      name: 'fee',
      desc: '',
      args: [],
    );
  }

  /// `Tax`
  String get tax {
    return Intl.message(
      'Tax',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `Total invest`
  String get invest_total {
    return Intl.message(
      'Total invest',
      name: 'invest_total',
      desc: '',
      args: [],
    );
  }

  /// `Bond assets`
  String get bond_assets {
    return Intl.message(
      'Bond assets',
      name: 'bond_assets',
      desc: '',
      args: [],
    );
  }

  /// `Bond history`
  String get bond_history {
    return Intl.message(
      'Bond history',
      name: 'bond_history',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Stt`
  String get status_short {
    return Intl.message(
      'Stt',
      name: 'status_short',
      desc: '',
      args: [],
    );
  }

  /// `Instructions transfers`
  String get instructions_transfers {
    return Intl.message(
      'Instructions transfers',
      name: 'instructions_transfers',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get account_user {
    return Intl.message(
      'User',
      name: 'account_user',
      desc: '',
      args: [],
    );
  }

  /// `Open on`
  String get open_on {
    return Intl.message(
      'Open on',
      name: 'open_on',
      desc: '',
      args: [],
    );
  }

  /// `Start day`
  String get start_day {
    return Intl.message(
      'Start day',
      name: 'start_day',
      desc: '',
      args: [],
    );
  }

  /// `End day`
  String get end_day {
    return Intl.message(
      'End day',
      name: 'end_day',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Acc`
  String get account_short {
    return Intl.message(
      'Acc',
      name: 'account_short',
      desc: '',
      args: [],
    );
  }

  /// `Profit total`
  String get profit_total {
    return Intl.message(
      'Profit total',
      name: 'profit_total',
      desc: '',
      args: [],
    );
  }

  /// `Stock code`
  String get stock_code {
    return Intl.message(
      'Stock code',
      name: 'stock_code',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Volume`
  String get volume_short {
    return Intl.message(
      'Volume',
      name: 'volume_short',
      desc: '',
      args: [],
    );
  }

  /// `Gain loss (%)`
  String get gain_loss_percent {
    return Intl.message(
      'Gain loss (%)',
      name: 'gain_loss_percent',
      desc: '',
      args: [],
    );
  }

  /// `Gain loss value`
  String get gain_loss_value {
    return Intl.message(
      'Gain loss value',
      name: 'gain_loss_value',
      desc: '',
      args: [],
    );
  }

  /// `Sell T0`
  String get sell_t0 {
    return Intl.message(
      'Sell T0',
      name: 'sell_t0',
      desc: '',
      args: [],
    );
  }

  /// `Sell T1`
  String get sell_t1 {
    return Intl.message(
      'Sell T1',
      name: 'sell_t1',
      desc: '',
      args: [],
    );
  }

  /// `Sell T2`
  String get sell_t2 {
    return Intl.message(
      'Sell T2',
      name: 'sell_t2',
      desc: '',
      args: [],
    );
  }

  /// `Sell back`
  String get sell_t_back {
    return Intl.message(
      'Sell back',
      name: 'sell_t_back',
      desc: '',
      args: [],
    );
  }

  /// `Total transfer`
  String get total_transfer {
    return Intl.message(
      'Total transfer',
      name: 'total_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Gain Loss Temporary`
  String get gain_loss_temporary {
    return Intl.message(
      'Gain Loss Temporary',
      name: 'gain_loss_temporary',
      desc: '',
      args: [],
    );
  }

  /// `Bank account`
  String get bank_account {
    return Intl.message(
      'Bank account',
      name: 'bank_account',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get content_transfer {
    return Intl.message(
      'Content',
      name: 'content_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Policy`
  String get policy_use {
    return Intl.message(
      'Policy',
      name: 'policy_use',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get contact_support {
    return Intl.message(
      'Support',
      name: 'contact_support',
      desc: '',
      args: [],
    );
  }

  /// `Total assets`
  String get total_assets {
    return Intl.message(
      'Total assets',
      name: 'total_assets',
      desc: '',
      args: [],
    );
  }

  /// `Cash balance`
  String get cash_balance {
    return Intl.message(
      'Cash balance',
      name: 'cash_balance',
      desc: '',
      args: [],
    );
  }

  /// `Collaborative Assets`
  String get collaborative_assets {
    return Intl.message(
      'Collaborative Assets',
      name: 'collaborative_assets',
      desc: '',
      args: [],
    );
  }

  /// `Collaborative assets total`
  String get collaborative_assets_total {
    return Intl.message(
      'Collaborative assets total',
      name: 'collaborative_assets_total',
      desc: '',
      args: [],
    );
  }

  /// `Deposit fee`
  String get deposit_fee {
    return Intl.message(
      'Deposit fee',
      name: 'deposit_fee',
      desc: '',
      args: [],
    );
  }

  /// `Volumn`
  String get volumn {
    return Intl.message(
      'Volumn',
      name: 'volumn',
      desc: '',
      args: [],
    );
  }

  /// `Ceil`
  String get ceil {
    return Intl.message(
      'Ceil',
      name: 'ceil',
      desc: '',
      args: [],
    );
  }

  /// `Floor`
  String get floor {
    return Intl.message(
      'Floor',
      name: 'floor',
      desc: '',
      args: [],
    );
  }

  /// `Reference`
  String get reference {
    return Intl.message(
      'Reference',
      name: 'reference',
      desc: '',
      args: [],
    );
  }

  /// `Ref`
  String get reference_short {
    return Intl.message(
      'Ref',
      name: 'reference_short',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get buy {
    return Intl.message(
      'Buy',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `Sell`
  String get sell {
    return Intl.message(
      'Sell',
      name: 'sell',
      desc: '',
      args: [],
    );
  }

  /// `Select account`
  String get select_account {
    return Intl.message(
      'Select account',
      name: 'select_account',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_step {
    return Intl.message(
      'Continue',
      name: 'continue_step',
      desc: '',
      args: [],
    );
  }

  /// `Register form`
  String get register_form {
    return Intl.message(
      'Register form',
      name: 'register_form',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get full_name {
    return Intl.message(
      'Full name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Please input full name`
  String get please_input_full_name {
    return Intl.message(
      'Please input full name',
      name: 'please_input_full_name',
      desc: '',
      args: [],
    );
  }

  /// `Please input phone number`
  String get please_input_phone_number {
    return Intl.message(
      'Please input phone number',
      name: 'please_input_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Phone not valid`
  String get phone_not_valid {
    return Intl.message(
      'Phone not valid',
      name: 'phone_not_valid',
      desc: '',
      args: [],
    );
  }

  /// `Please input email`
  String get please_input_email {
    return Intl.message(
      'Please input email',
      name: 'please_input_email',
      desc: '',
      args: [],
    );
  }

  /// `Email not valid`
  String get email_not_valid {
    return Intl.message(
      'Email not valid',
      name: 'email_not_valid',
      desc: '',
      args: [],
    );
  }

  /// `Referral code`
  String get referral_code {
    return Intl.message(
      'Referral code',
      name: 'referral_code',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get agree {
    return Intl.message(
      'Agree',
      name: 'agree',
      desc: '',
      args: [],
    );
  }

  /// `Terms & condition`
  String get terms_and_condition {
    return Intl.message(
      'Terms & condition',
      name: 'terms_and_condition',
      desc: '',
      args: [],
    );
  }

  /// `Please agree terms & condition`
  String get terms_and_condition_valid {
    return Intl.message(
      'Please agree terms & condition',
      name: 'terms_and_condition_valid',
      desc: '',
      args: [],
    );
  }

  /// `Confirm OTP`
  String get confirm_otp {
    return Intl.message(
      'Confirm OTP',
      name: 'confirm_otp',
      desc: '',
      args: [],
    );
  }

  /// `Please input OTP`
  String get please_input_OTP {
    return Intl.message(
      'Please input OTP',
      name: 'please_input_OTP',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Resent OTP`
  String get resent {
    return Intl.message(
      'Resent OTP',
      name: 'resent',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get failed {
    return Intl.message(
      'Failed',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `Activated account`
  String get activated_account {
    return Intl.message(
      'Activated account',
      name: 'activated_account',
      desc: '',
      args: [],
    );
  }

  /// `Activated now`
  String get activated_now {
    return Intl.message(
      'Activated now',
      name: 'activated_now',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Choose your identity document`
  String get choose_identity {
    return Intl.message(
      'Choose your identity document',
      name: 'choose_identity',
      desc: '',
      args: [],
    );
  }

  /// `Passport`
  String get passport {
    return Intl.message(
      'Passport',
      name: 'passport',
      desc: '',
      args: [],
    );
  }

  /// `Identity card`
  String get identity_card {
    return Intl.message(
      'Identity card',
      name: 'identity_card',
      desc: '',
      args: [],
    );
  }

  /// `Choose`
  String get choose {
    return Intl.message(
      'Choose',
      name: 'choose',
      desc: '',
      args: [],
    );
  }

  /// `Take photo confirm`
  String get take_photo_confirm {
    return Intl.message(
      'Take photo confirm',
      name: 'take_photo_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Margin rate`
  String get mr {
    return Intl.message(
      'Margin rate',
      name: 'mr',
      desc: '',
      args: [],
    );
  }

  /// `PP`
  String get pp {
    return Intl.message(
      'PP',
      name: 'pp',
      desc: '',
      args: [],
    );
  }

  /// `PP`
  String get pp_1 {
    return Intl.message(
      'PP',
      name: 'pp_1',
      desc: '',
      args: [],
    );
  }

  /// `EE`
  String get ee {
    return Intl.message(
      'EE',
      name: 'ee',
      desc: '',
      args: [],
    );
  }

  /// `Maximum Available Buy Volumn`
  String get maxVolumeBuyAvaiable {
    return Intl.message(
      'Maximum Available Buy Volumn',
      name: 'maxVolumeBuyAvaiable',
      desc: '',
      args: [],
    );
  }

  /// `Maximum Available Sell Volumn`
  String get maxVolumeSellAvaiable {
    return Intl.message(
      'Maximum Available Sell Volumn',
      name: 'maxVolumeSellAvaiable',
      desc: '',
      args: [],
    );
  }

  /// `Maximum Available Buy Sell`
  String get maxVolumeSellBuy {
    return Intl.message(
      'Maximum Available Buy Sell',
      name: 'maxVolumeSellBuy',
      desc: '',
      args: [],
    );
  }

  /// `Take photo again`
  String get take_photo_again {
    return Intl.message(
      'Take photo again',
      name: 'take_photo_again',
      desc: '',
      args: [],
    );
  }

  /// `Use photo`
  String get use_photo {
    return Intl.message(
      'Use photo',
      name: 'use_photo',
      desc: '',
      args: [],
    );
  }

  /// `Profile info`
  String get profile_info {
    return Intl.message(
      'Profile info',
      name: 'profile_info',
      desc: '',
      args: [],
    );
  }

  /// `Account info`
  String get account_info {
    return Intl.message(
      'Account info',
      name: 'account_info',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get birthday {
    return Intl.message(
      'Birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `Issue date`
  String get issue_date_cmt {
    return Intl.message(
      'Issue date',
      name: 'issue_date_cmt',
      desc: '',
      args: [],
    );
  }

  /// `Issue location`
  String get issue_loc {
    return Intl.message(
      'Issue location',
      name: 'issue_loc',
      desc: '',
      args: [],
    );
  }

  /// `Redo`
  String get redo {
    return Intl.message(
      'Redo',
      name: 'redo',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel_short {
    return Intl.message(
      'Cancel',
      name: 'cancel_short',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Stock market`
  String get stockMarket {
    return Intl.message(
      'Stock market',
      name: 'stockMarket',
      desc: '',
      args: [],
    );
  }

  /// `Money exchange`
  String get money_exchange {
    return Intl.message(
      'Money exchange',
      name: 'money_exchange',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Margin product`
  String get margin_product {
    return Intl.message(
      'Margin product',
      name: 'margin_product',
      desc: '',
      args: [],
    );
  }

  /// `Order confirm`
  String get order_confirm {
    return Intl.message(
      'Order confirm',
      name: 'order_confirm',
      desc: '',
      args: [],
    );
  }

  /// `User guide`
  String get user_guide {
    return Intl.message(
      'User guide',
      name: 'user_guide',
      desc: '',
      args: [],
    );
  }

  /// `Statement`
  String get statement {
    return Intl.message(
      'Statement',
      name: 'statement',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get change_password {
    return Intl.message(
      'Change password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Order type`
  String get orderType {
    return Intl.message(
      'Order type',
      name: 'orderType',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Matched`
  String get match {
    return Intl.message(
      'Matched',
      name: 'match',
      desc: '',
      args: [],
    );
  }

  /// `Matched price`
  String get match_price {
    return Intl.message(
      'Matched price',
      name: 'match_price',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Order Number`
  String get order_number {
    return Intl.message(
      'Order Number',
      name: 'order_number',
      desc: '',
      args: [],
    );
  }

  /// `OrdN`
  String get order_number_short {
    return Intl.message(
      'OrdN',
      name: 'order_number_short',
      desc: '',
      args: [],
    );
  }

  /// `Invalid price`
  String get invalid_price {
    return Intl.message(
      'Invalid price',
      name: 'invalid_price',
      desc: '',
      args: [],
    );
  }

  /// `Invalid volumn`
  String get invalid_volumn {
    return Intl.message(
      'Invalid volumn',
      name: 'invalid_volumn',
      desc: '',
      args: [],
    );
  }

  /// `Volumn must be positive`
  String get vol_is_not_positive {
    return Intl.message(
      'Volumn must be positive',
      name: 'vol_is_not_positive',
      desc: '',
      args: [],
    );
  }

  /// `Volumn must be an integer`
  String get vol_is_not_integer {
    return Intl.message(
      'Volumn must be an integer',
      name: 'vol_is_not_integer',
      desc: '',
      args: [],
    );
  }

  /// `Stock code is empty`
  String get empty_stockcode {
    return Intl.message(
      'Stock code is empty',
      name: 'empty_stockcode',
      desc: '',
      args: [],
    );
  }

  /// `Order time`
  String get order_time {
    return Intl.message(
      'Order time',
      name: 'order_time',
      desc: '',
      args: [],
    );
  }

  /// `Match time`
  String get match_time {
    return Intl.message(
      'Match time',
      name: 'match_time',
      desc: '',
      args: [],
    );
  }

  /// `Cancel time`
  String get cancel_time {
    return Intl.message(
      'Cancel time',
      name: 'cancel_time',
      desc: '',
      args: [],
    );
  }

  /// `Order volumn`
  String get order_volumn {
    return Intl.message(
      'Order volumn',
      name: 'order_volumn',
      desc: '',
      args: [],
    );
  }

  /// `Match volumn`
  String get match_volumn {
    return Intl.message(
      'Match volumn',
      name: 'match_volumn',
      desc: '',
      args: [],
    );
  }

  /// `Cancel volumn`
  String get cancel_volumn {
    return Intl.message(
      'Cancel volumn',
      name: 'cancel_volumn',
      desc: '',
      args: [],
    );
  }

  /// `Order price`
  String get order_price {
    return Intl.message(
      'Order price',
      name: 'order_price',
      desc: '',
      args: [],
    );
  }

  /// `Average match price`
  String get aver_match_price {
    return Intl.message(
      'Average match price',
      name: 'aver_match_price',
      desc: '',
      args: [],
    );
  }

  /// `AVG`
  String get aver_short {
    return Intl.message(
      'AVG',
      name: 'aver_short',
      desc: '',
      args: [],
    );
  }

  /// `Order source`
  String get order_source {
    return Intl.message(
      'Order source',
      name: 'order_source',
      desc: '',
      args: [],
    );
  }

  /// `Cancel order confirmation`
  String get confirm_cancel_order {
    return Intl.message(
      'Cancel order confirmation',
      name: 'confirm_cancel_order',
      desc: '',
      args: [],
    );
  }

  /// `Change order confirmation`
  String get confirm_change_order {
    return Intl.message(
      'Change order confirmation',
      name: 'confirm_change_order',
      desc: '',
      args: [],
    );
  }

  /// `Change order successfully`
  String get change_order_successfully {
    return Intl.message(
      'Change order successfully',
      name: 'change_order_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Cancel order`
  String get cancel_order {
    return Intl.message(
      'Cancel order',
      name: 'cancel_order',
      desc: '',
      args: [],
    );
  }

  /// `Cancel chose orders`
  String get cancel_chose_orders {
    return Intl.message(
      'Cancel chose orders',
      name: 'cancel_chose_orders',
      desc: '',
      args: [],
    );
  }

  /// `Cancel all orders`
  String get cancel_all_orders {
    return Intl.message(
      'Cancel all orders',
      name: 'cancel_all_orders',
      desc: '',
      args: [],
    );
  }

  /// `Change order`
  String get change_order {
    return Intl.message(
      'Change order',
      name: 'change_order',
      desc: '',
      args: [],
    );
  }

  /// `Order detail`
  String get order_detail {
    return Intl.message(
      'Order detail',
      name: 'order_detail',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to cancel this order?`
  String get are_you_sure_cancel_this_order {
    return Intl.message(
      'Are you sure to cancel this order?',
      name: 'are_you_sure_cancel_this_order',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to cancel all order?`
  String get are_you_sure_cancel_all_order {
    return Intl.message(
      'Are you sure to cancel all order?',
      name: 'are_you_sure_cancel_all_order',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Waiting match`
  String get wating_match {
    return Intl.message(
      'Waiting match',
      name: 'wating_match',
      desc: '',
      args: [],
    );
  }

  /// `Partial matched`
  String get partial_matched {
    return Intl.message(
      'Partial matched',
      name: 'partial_matched',
      desc: '',
      args: [],
    );
  }

  /// `Matched`
  String get matched {
    return Intl.message(
      'Matched',
      name: 'matched',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message(
      'Cancelled',
      name: 'cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Waiting cancelled`
  String get waiting_cancelled {
    return Intl.message(
      'Waiting cancelled',
      name: 'waiting_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get rejected {
    return Intl.message(
      'Rejected',
      name: 'rejected',
      desc: '',
      args: [],
    );
  }

  /// `Add category`
  String get add_category {
    return Intl.message(
      'Add category',
      name: 'add_category',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Edit category`
  String get edit_category {
    return Intl.message(
      'Edit category',
      name: 'edit_category',
      desc: '',
      args: [],
    );
  }

  /// `edit`
  String get edit {
    return Intl.message(
      'edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Nhập vào ô tìm kiếm để thêm mã\nđầu tiên vào danh mục`
  String get no_stock_hint_text {
    return Intl.message(
      'Nhập vào ô tìm kiếm để thêm mã\nđầu tiên vào danh mục',
      name: 'no_stock_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `Add stock`
  String get add_stock {
    return Intl.message(
      'Add stock',
      name: 'add_stock',
      desc: '',
      args: [],
    );
  }

  /// `Thanks`
  String get tks {
    return Intl.message(
      'Thanks',
      name: 'tks',
      desc: '',
      args: [],
    );
  }

  /// `About choose`
  String get about_choose {
    return Intl.message(
      'About choose',
      name: 'about_choose',
      desc: '',
      args: [],
    );
  }

  /// `Complete request`
  String get complete {
    return Intl.message(
      'Complete request',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `Active account`
  String get active_account {
    return Intl.message(
      'Active account',
      name: 'active_account',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for few minute`
  String get waiting_few_minute {
    return Intl.message(
      'Waiting for few minute',
      name: 'waiting_few_minute',
      desc: '',
      args: [],
    );
  }

  /// `Yêu cầu sẽ được xử lý trong vòng 01 giờ làm việc`
  String get success_title1 {
    return Intl.message(
      'Yêu cầu sẽ được xử lý trong vòng 01 giờ làm việc',
      name: 'success_title1',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có thể trải nghiệm VF TRADE ngya sau khi tài khoản được duyệt.`
  String get success_title2 {
    return Intl.message(
      'Bạn có thể trải nghiệm VF TRADE ngya sau khi tài khoản được duyệt.',
      name: 'success_title2',
      desc: '',
      args: [],
    );
  }

  /// `Notice`
  String get notice {
    return Intl.message(
      'Notice',
      name: 'notice',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get news {
    return Intl.message(
      'News',
      name: 'news',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get popular {
    return Intl.message(
      'Popular',
      name: 'popular',
      desc: '',
      args: [],
    );
  }

  /// `Increase`
  String get increase {
    return Intl.message(
      'Increase',
      name: 'increase',
      desc: '',
      args: [],
    );
  }

  /// `Decrease`
  String get decrease {
    return Intl.message(
      'Decrease',
      name: 'decrease',
      desc: '',
      args: [],
    );
  }

  /// `Remember account`
  String get remember_account {
    return Intl.message(
      'Remember account',
      name: 'remember_account',
      desc: '',
      args: [],
    );
  }

  /// `Authentication by Face ID`
  String get authentication_by_face_id {
    return Intl.message(
      'Authentication by Face ID',
      name: 'authentication_by_face_id',
      desc: '',
      args: [],
    );
  }

  /// `Register Online`
  String get register_online {
    return Intl.message(
      'Register Online',
      name: 'register_online',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get transfer {
    return Intl.message(
      'Transfer',
      name: 'transfer',
      desc: '',
      args: [],
    );
  }

  /// `Bond`
  String get bond {
    return Intl.message(
      'Bond',
      name: 'bond',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Statement`
  String get Statement {
    return Intl.message(
      'Statement',
      name: 'Statement',
      desc: '',
      args: [],
    );
  }

  /// `Variable`
  String get variable {
    return Intl.message(
      'Variable',
      name: 'variable',
      desc: '',
      args: [],
    );
  }

  /// `Stock Detail`
  String get stock_detail {
    return Intl.message(
      'Stock Detail',
      name: 'stock_detail',
      desc: '',
      args: [],
    );
  }

  /// `Short/Long`
  String get long_short {
    return Intl.message(
      'Short/Long',
      name: 'long_short',
      desc: '',
      args: [],
    );
  }

  /// `Total volumn`
  String get total_amount {
    return Intl.message(
      'Total volumn',
      name: 'total_amount',
      desc: '',
      args: [],
    );
  }

  /// `Over view`
  String get over_view {
    return Intl.message(
      'Over view',
      name: 'over_view',
      desc: '',
      args: [],
    );
  }

  /// `Analytics`
  String get analytics {
    return Intl.message(
      'Analytics',
      name: 'analytics',
      desc: '',
      args: [],
    );
  }

  /// `Finance`
  String get finance {
    return Intl.message(
      'Finance',
      name: 'finance',
      desc: '',
      args: [],
    );
  }

  /// `Step Price`
  String get step_price {
    return Intl.message(
      'Step Price',
      name: 'step_price',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
