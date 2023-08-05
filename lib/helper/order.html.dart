
import 'package:bnaa/helper/helper.dart';
import 'package:bnaa/models/order.dart';
import 'package:bnaa/models/product.dart';
import 'package:bnaa/views/widgets/timeLine.dart';
import 'package:flutter/widgets.dart';
import "package:get/get.dart";

Future<String?> getFormatHtml({
  required BuildContext context,
  bool? isArabic = false,
  required Order command,
}) async {
  String logo = await logoBase64();
  String html = '''
<!DOCTYPE html>
<html >
<head>
   $style
</head>

<body dir="${Get.locale!.languageCode == "fr" ? 'ltr' : 'rtl'}" >
    <header>
        <img width="120px"  src="${"data:image/png;base64, " + logo}" />

    </header>

    <table class="items">

        <tbody>
            <tr>
                <td class="line" style="text-align:${Get.locale?.languageCode == 'fr' ? 'left' : 'right'}">${'order code'.tr}</td>
                <td class="price line">${command.code.toString()}</td>
            </tr>
            <tr>
                <td class="line" style="text-align:${Get.locale?.languageCode == 'fr' ? 'left' : 'right'}">${'order status'.tr}</td>
                <td class="price line">${etats[command.status]!.tr}</td>
            </tr>
            <tr>
                <td class="line" style="text-align:${Get.locale?.languageCode == 'fr' ? 'left' : 'right'}">${'requested on'.tr}</td>
                <td class="price line">${command.createdAt.toString()}</td>
            </tr>
            <tr>
                <td class="line" style="text-align:${Get.locale?.languageCode == 'fr' ? 'left' : 'right'}">${'invoice for'.tr}</td>
                <td class="price line">${command.customer!.name}</td>
            </tr>
            <tr>
                <td class="line" style="text-align:${Get.locale?.languageCode == 'fr' ? 'left' : 'right'}">${'phone'.tr}</td>
                <td class="price line">${command.customer!.phone.toString()}</td>
            </tr>
            <tr>
                <td class="line" style="text-align:${Get.locale?.languageCode == 'fr' ? 'left' : 'right'}">${'client address'.tr}</td>
                <td class="price line">${command.shippingInfo!.address.toString()}</td>
            </tr>
            <tr>
                <td  class="sum-up line" style="text-align:${Get.locale?.languageCode == 'fr' ? 'left' : 'right'}"><b>${'amount to pay'.tr}</b></td>
                <td class="line price"><b>${command.grandTotal.toString() + " " + 'da'.tr}</b></td>
            </tr>

         ${listProduct(command.listProducts ?? [])}


            <tr>
                <td  class="sum-up" style="text-align:${Get.locale?.languageCode == 'fr' ? 'left' : 'right'}"><b>${'delivery'.tr}</b></td>
                <td class=" price"><b>${command.shippingCost.toString() + " " + 'da'.tr}</b></td>
            </tr>

            <tr>
                <th  class="total text" style="text-align:${Get.locale?.languageCode == 'fr' ? 'left' : 'right'}">${'total'.tr}</th>
                <th class="total price">${command.grandTotal.toString() + " " + "da".tr}</th>
            </tr>
        </tbody>
    </table>
    <footer style="text-align:center">
        <p>${command.storeName.toString()}</p>
        <p>${command.customer!.phone.toString()}</p>
        <p> ${command.shippingInfo!.wilaya},${command.shippingInfo!.commune},${command.shippingInfo!.address}</p>
    </footer>
</body>

</html>

''';

  return html;
}

String listProduct(List<Product> listProducts) {
  String s = "";
  for (var index = 0; index < listProducts.length; index++) {
    s = s +
        '''
    <tr>
        <td  class="sum-up ${index == listProducts.length - 1 ? "line" : ""}" style="text-align:${Get.locale?.languageCode == 'fr' ? 'left' : 'right'}">${listProducts[index].name.toString() + " " + "1 " + (Get.locale?.languageCode == 'fr' ? listProducts[index].unitFr.toString() : listProducts[index].unitAr.toString()) + " X " + listProducts[index].quantity!.toInt().toString()}</td>
        <td class="price ${index == listProducts.length - 1 ? "line" : ""}">${double.parse(listProducts[index].price.toString()) * double.parse(listProducts[index].quantity.toString())}  ${'da'.tr}</td>
    </tr>
''';
  }
  return s;
}

String style = '''
 <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'PT Sans', sans-serif;
        }

        @page {
            size: 2.8in 11in;
            margin-top: 0cm;
            margin-left: 0cm;
            margin-right: 0cm;
        }

        table {
            width: 100%;
        }

        tr {
            width: 100%;

        }

        h1 {
            text-align: center;
            vertical-align: middle;
        }

        #logo {
            width: 20%;
            text-align: center;
            -webkit-align-content: center;
            align-content: center;
            padding: 5px;
            margin: 2px;
            display: block;
            margin: 0 auto;
        }

        header {
            width: 100%;
            text-align: center;
            -webkit-align-content: center;
            align-content: center;
            vertical-align: middle;
        }

        .items thead {
            text-align: center;
        }

        .center-align {
            text-align: center;
        }

        .bill-details td {
            font-size: 12px;
        }

        .receipt {
            font-size: medium;
        }

        .items .heading {
            font-size: 12.5px;
            text-transform: uppercase;
            border-top:1px solid black;
            margin-bottom: 4px;
            border-bottom: 1px solid black;
            vertical-align: middle;
        }

        .items thead tr th:first-child,
        .items tbody tr td:first-child {
            width: 47%;
            min-width: 47%;
            max-width: 47%;
            word-break: break-all;
            text-align: ${Get.locale?.languageCode == 'fr' ? 'left' : 'right'};
        }

        .items td {
            font-size: 12px;
            text-align: ${Get.locale?.languageCode == 'fr' ? 'left' : 'right'};
            vertical-align: bottom;
        }


        /* .sum-up {
            text-align: ${Get.locale?.languageCode == 'fr' ? 'right' : 'left'} !important;
        } */
        .total {
            font-size: 13px;
            border-top:1px solid black !important;
            border-bottom:1px solid black !important;
        }
        .total.price {
            text-align: ${Get.locale?.languageCode == 'fr' ? 'right' : 'left'};
        }

        .total.text {
            text-align: ${Get.locale?.languageCode == 'fr' ? 'left' : 'right'};
        }

        .line {
            border-bottom:1px solid rgba(0, 0, 0, 0.3) !important;
        }
        .heading.rate {
            width: 20%;
        }
        .heading.amount {
            width: 25%;
        }
        .heading.qty {
            width: 5%
        }
        p {
            padding: 1px;
            margin: 0;
        }
        section, footer {
            font-size: 12px;
        }
    </style>
''';
