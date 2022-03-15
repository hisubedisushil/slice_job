import 'dart:convert';

/// status : true
/// message : "Page Static Listed Successfully."
/// data : {"id":"26","category":"Terms And Use","post_title":"Terms of Use","post_desc":"<p><strong>Fees and Services</strong><br />\r\n&nbsp;</p>\r\n\r\n<ul>\r\n\t<li>Membership on the Site is free. Sicejob.com does not charge any fee for browsing, bidding and buying listed items on the Site. Slicejob.com charges transaction fees to all sellers when their item is successfully sold on the Site, listing fees for classifieds and special listing fees to sellers who use the special listing feature for listing their items.&nbsp;</li>\r\n\t<li>Sellers must pay all fees due and payable to Slicejob.com after a successful sale and in the case that a buyer does not complete the transaction, the seller may seek a refund of the relevant transaction fees from Slice.com by submitting an online no-sale claim.&nbsp;</li>\r\n</ul>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ul>\r\n\t<li>Before you list an item for sale through the Site, we request you to review the fees that you will be charged based on our Fees &amp; Credit Policy which we may amend from time to time with immediate effect by posting the changes on the Site.&nbsp;</li>\r\n\t<li>Slicejob.com may choose to temporarily change the fees for our services for promotional events (for example, free shipping days) or new services, and such temporary changes are effective in accordance with their terms when we post them on the Site.</li>\r\n</ul>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ul>\r\n\t<li>Unless otherwise stated, all fees shall be quoted in your country&#39;s currency. You must pay all fees payable to Slicejob.com (and any applicable taxes or charges) within 15 days of the date of any invoice to you from Slicejob.com with a valid payment method as set out in our Fees &amp; Credit Policy.</li>\r\n\t<li>The rate for posting ads will be based on the time frame and types of ads classified, property or job</li>\r\n\t<li>The user also has the options to use lump sum payment packages where no additional payment required for positing job subject to the time frame specified in the package&nbsp;</li>\r\n\t<li>If the ecommerce user wants to sell the product, hotel rooms and events-party venues using our wallet the transaction fees deducted is 12.5%. However, the rates are always negotiable.</li>\r\n</ul>\r\n\r\n<p><strong>Fees &amp; Credit Policy</strong>.&nbsp;</p>\r\n\r\n<ul>\r\n\t<li>Issue you with a warning regarding the non-payment in question.</li>\r\n\t<li>Temporarily or indefinitely suspend, limit or withdraw your access to the Site and/or your membership, if you fail to make the outstanding payment within 7 calendar days of Slicejob.com issuing a warning to you.</li>\r\n\t<li>Slicejob.com also reserves the right to take any necessary steps including legal action in case of non-payment of fees by you to slicejob.com</li>\r\n\t<li>Invoice you for a fixed late payment fee (as set out in our Fees and Credit Policy from time to time).</li>\r\n\t<li>Take any steps Slicejob.com considers necessary including without limitation legal action for recovery of the outstanding fees and/or any applicable taxes and charges</li>\r\n\t<li>In case of non-payment of fees and/or any applicable taxes and charges by you to slicejob.com, without prejudice to any other rights and remedies of Slicejob.com under this User Agreement or at law, Slicejob.com without liability reserves the right to:</li>\r\n</ul>\r\n\r\n<p><strong>Place your Ads</strong><br />\r\n1.&nbsp;&nbsp; &nbsp;Users aren&rsquo;t be able to edit the Job ads, Property ads and Classified ads after uploading into the system<br />\r\n2.&nbsp;&nbsp; &nbsp;The ads will be published by the company after authentication of the payments from finance department.<br />\r\n3.&nbsp;&nbsp; &nbsp;Individuals are not able to place Job ads, while company and college can use such functions.<br />\r\n4.&nbsp;&nbsp; &nbsp;The company has to submit VAT/PAN no along with scan copy of registration certificate for using the platform of online exam and tests.</p>\r\n\r\n<p><strong>Payments&nbsp;</strong><br />\r\n1.&nbsp;&nbsp; &nbsp;The payments can be either made using Esewa, Bank Transfer and Master card or Visa Card<br />\r\n2.&nbsp;&nbsp; &nbsp;The customer has to upload deposit slip and inform the customer service for the amount paid via bank transfer.</p>\r\n\r\n<p><strong>Delivery Charge</strong><br />\r\n1.&nbsp;&nbsp; &nbsp;Additional delivery charge will be collected form users for the parcel weighing more than 10 kg, in other case for delivery charge inside Kathmandu valley will be as fixed in the invoice at the time of purchase.&nbsp;<br />\r\n2.&nbsp;&nbsp; &nbsp;The delivery charge for D/O outside Kathmandu valley will depend upon the distance and weight of the parcel.<br />\r\n&nbsp;<br />\r\n<strong>Cancellation of Product Order/Service Order</strong><br />\r\n1.&nbsp;&nbsp; &nbsp;The product order can be cancelled only before 24 hrs of delivery date . The customer has to inform customer care with the reasons for cancelling the order<br />\r\n2.&nbsp;&nbsp; &nbsp;The customer has to pay the delivery charge if the products are already delivered&nbsp;<br />\r\n3.&nbsp;&nbsp; &nbsp;The hotel booking can only be cancelled before 48 hrs of booking date. In other circumstances the booking can&rsquo;t be cancelled and company won&rsquo;t be liable.<br />\r\n4.&nbsp;&nbsp; &nbsp;The party venue booking can be cancelled before one week of booking date. In other case the company will make refund after deducting the administrative and charges involved<br />\r\n5.&nbsp;&nbsp; &nbsp;The company won&rsquo;t provide any warranty and guarantee for any items sold by the third party. However, warranty guarantee will be available only on specific brands and items from the certified vendors. The company use its own discretion for this certification.</p>\r\n\r\n<p><strong>Refund Policy</strong><br />\r\n1.&nbsp;&nbsp; &nbsp;No refund is available for the payments being received for classified ads, job ads and property ads<br />\r\n2.&nbsp;&nbsp; &nbsp;Refund is available only for cancellation of product orders and booking orders.<br />\r\n3.&nbsp;&nbsp; &nbsp;The refund for cancellation of order will be available only after 15-20 working days and will be transferred to the bank account of the customer.<br />\r\n4.&nbsp;&nbsp; &nbsp;The refund is available from the customer service counter. The customer has to submit the necessary documents for initiation the refund process. No verbal and tele conversation will be entertained in this case.</p>\r\n\r\n<p><br />\r\n&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n","updated_by":"slicejob","updated_date":"09 Nov 2017 04:07:54","status":"Published"}

TermResponseModel termResponseModelFromJson(String str) =>
    TermResponseModel.fromJson(json.decode(str));
String termResponseModelToJson(TermResponseModel data) =>
    json.encode(data.toJson());

class TermResponseModel {
  TermResponseModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  TermResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;

  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// id : "26"
/// category : "Terms And Use"
/// post_title : "Terms of Use"
/// post_desc : "<p><strong>Fees and Services</strong><br />\r\n&nbsp;</p>\r\n\r\n<ul>\r\n\t<li>Membership on the Site is free. Sicejob.com does not charge any fee for browsing, bidding and buying listed items on the Site. Slicejob.com charges transaction fees to all sellers when their item is successfully sold on the Site, listing fees for classifieds and special listing fees to sellers who use the special listing feature for listing their items.&nbsp;</li>\r\n\t<li>Sellers must pay all fees due and payable to Slicejob.com after a successful sale and in the case that a buyer does not complete the transaction, the seller may seek a refund of the relevant transaction fees from Slice.com by submitting an online no-sale claim.&nbsp;</li>\r\n</ul>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ul>\r\n\t<li>Before you list an item for sale through the Site, we request you to review the fees that you will be charged based on our Fees &amp; Credit Policy which we may amend from time to time with immediate effect by posting the changes on the Site.&nbsp;</li>\r\n\t<li>Slicejob.com may choose to temporarily change the fees for our services for promotional events (for example, free shipping days) or new services, and such temporary changes are effective in accordance with their terms when we post them on the Site.</li>\r\n</ul>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ul>\r\n\t<li>Unless otherwise stated, all fees shall be quoted in your country&#39;s currency. You must pay all fees payable to Slicejob.com (and any applicable taxes or charges) within 15 days of the date of any invoice to you from Slicejob.com with a valid payment method as set out in our Fees &amp; Credit Policy.</li>\r\n\t<li>The rate for posting ads will be based on the time frame and types of ads classified, property or job</li>\r\n\t<li>The user also has the options to use lump sum payment packages where no additional payment required for positing job subject to the time frame specified in the package&nbsp;</li>\r\n\t<li>If the ecommerce user wants to sell the product, hotel rooms and events-party venues using our wallet the transaction fees deducted is 12.5%. However, the rates are always negotiable.</li>\r\n</ul>\r\n\r\n<p><strong>Fees &amp; Credit Policy</strong>.&nbsp;</p>\r\n\r\n<ul>\r\n\t<li>Issue you with a warning regarding the non-payment in question.</li>\r\n\t<li>Temporarily or indefinitely suspend, limit or withdraw your access to the Site and/or your membership, if you fail to make the outstanding payment within 7 calendar days of Slicejob.com issuing a warning to you.</li>\r\n\t<li>Slicejob.com also reserves the right to take any necessary steps including legal action in case of non-payment of fees by you to slicejob.com</li>\r\n\t<li>Invoice you for a fixed late payment fee (as set out in our Fees and Credit Policy from time to time).</li>\r\n\t<li>Take any steps Slicejob.com considers necessary including without limitation legal action for recovery of the outstanding fees and/or any applicable taxes and charges</li>\r\n\t<li>In case of non-payment of fees and/or any applicable taxes and charges by you to slicejob.com, without prejudice to any other rights and remedies of Slicejob.com under this User Agreement or at law, Slicejob.com without liability reserves the right to:</li>\r\n</ul>\r\n\r\n<p><strong>Place your Ads</strong><br />\r\n1.&nbsp;&nbsp; &nbsp;Users aren&rsquo;t be able to edit the Job ads, Property ads and Classified ads after uploading into the system<br />\r\n2.&nbsp;&nbsp; &nbsp;The ads will be published by the company after authentication of the payments from finance department.<br />\r\n3.&nbsp;&nbsp; &nbsp;Individuals are not able to place Job ads, while company and college can use such functions.<br />\r\n4.&nbsp;&nbsp; &nbsp;The company has to submit VAT/PAN no along with scan copy of registration certificate for using the platform of online exam and tests.</p>\r\n\r\n<p><strong>Payments&nbsp;</strong><br />\r\n1.&nbsp;&nbsp; &nbsp;The payments can be either made using Esewa, Bank Transfer and Master card or Visa Card<br />\r\n2.&nbsp;&nbsp; &nbsp;The customer has to upload deposit slip and inform the customer service for the amount paid via bank transfer.</p>\r\n\r\n<p><strong>Delivery Charge</strong><br />\r\n1.&nbsp;&nbsp; &nbsp;Additional delivery charge will be collected form users for the parcel weighing more than 10 kg, in other case for delivery charge inside Kathmandu valley will be as fixed in the invoice at the time of purchase.&nbsp;<br />\r\n2.&nbsp;&nbsp; &nbsp;The delivery charge for D/O outside Kathmandu valley will depend upon the distance and weight of the parcel.<br />\r\n&nbsp;<br />\r\n<strong>Cancellation of Product Order/Service Order</strong><br />\r\n1.&nbsp;&nbsp; &nbsp;The product order can be cancelled only before 24 hrs of delivery date . The customer has to inform customer care with the reasons for cancelling the order<br />\r\n2.&nbsp;&nbsp; &nbsp;The customer has to pay the delivery charge if the products are already delivered&nbsp;<br />\r\n3.&nbsp;&nbsp; &nbsp;The hotel booking can only be cancelled before 48 hrs of booking date. In other circumstances the booking can&rsquo;t be cancelled and company won&rsquo;t be liable.<br />\r\n4.&nbsp;&nbsp; &nbsp;The party venue booking can be cancelled before one week of booking date. In other case the company will make refund after deducting the administrative and charges involved<br />\r\n5.&nbsp;&nbsp; &nbsp;The company won&rsquo;t provide any warranty and guarantee for any items sold by the third party. However, warranty guarantee will be available only on specific brands and items from the certified vendors. The company use its own discretion for this certification.</p>\r\n\r\n<p><strong>Refund Policy</strong><br />\r\n1.&nbsp;&nbsp; &nbsp;No refund is available for the payments being received for classified ads, job ads and property ads<br />\r\n2.&nbsp;&nbsp; &nbsp;Refund is available only for cancellation of product orders and booking orders.<br />\r\n3.&nbsp;&nbsp; &nbsp;The refund for cancellation of order will be available only after 15-20 working days and will be transferred to the bank account of the customer.<br />\r\n4.&nbsp;&nbsp; &nbsp;The refund is available from the customer service counter. The customer has to submit the necessary documents for initiation the refund process. No verbal and tele conversation will be entertained in this case.</p>\r\n\r\n<p><br />\r\n&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n"
/// updated_by : "slicejob"
/// updated_date : "09 Nov 2017 04:07:54"
/// status : "Published"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? id,
    String? category,
    String? postTitle,
    String? postDesc,
    String? updatedBy,
    String? updatedDate,
    String? status,
  }) {
    _id = id;
    _category = category;
    _postTitle = postTitle;
    _postDesc = postDesc;
    _updatedBy = updatedBy;
    _updatedDate = updatedDate;
    _status = status;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _category = json['category'];
    _postTitle = json['post_title'];
    _postDesc = json['post_desc'];
    _updatedBy = json['updated_by'];
    _updatedDate = json['updated_date'];
    _status = json['status'];
  }
  String? _id;
  String? _category;
  String? _postTitle;
  String? _postDesc;
  String? _updatedBy;
  String? _updatedDate;
  String? _status;

  String? get id => _id;
  String? get category => _category;
  String? get postTitle => _postTitle;
  String? get postDesc => _postDesc;
  String? get updatedBy => _updatedBy;
  String? get updatedDate => _updatedDate;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category'] = _category;
    map['post_title'] = _postTitle;
    map['post_desc'] = _postDesc;
    map['updated_by'] = _updatedBy;
    map['updated_date'] = _updatedDate;
    map['status'] = _status;
    return map;
  }
}
