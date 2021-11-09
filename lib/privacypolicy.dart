import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picsd/home_screen.dart';

class Privacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            '\t\t\t\t\t\t\t\t\t\t\t\tPrivacy Policy',
          ),
          backgroundColor: Colors.amber,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => HomeScreen()));
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 7, right: 7, top: 25),
                child: Text(
                  "**Privacy Policy**\n\n KSV team built the PicsD app as a Free app. This SERVICE is provided by KSV Team at no cost and is intended for use as is.\n\n This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.\n\nIf you choose to use my Service, then you aree to collection and use of information in relation to this Policy. The personal Information that I collect is used for providing and improving the Service. Iwill not use or share your information with anyone except as described in this Privacy Policy.\n\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at PicsD unless otherwise defined in this\nPrivacy Policy.\n\n**Information Collection and Use**\n\nFor better experience, while using ou Service, I may require you to provide us with certain personally identifiable information.The information that i request will be retaineed  on your device and is not collected by me in any way.\n\nThe app does not use third party services that may collect information used to identify you.\n\nLink to privacy policy of third party service providers used by the app\n\n*  [Google Play Service]\n(https://www.google.coom/policies/privacy/)\n*  [Google Analytics for Firebase]\n(https://firebasee.google.com/policies/analytiics)\n\n**Log Data**\n\nI want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol address, device name, operating system version,the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.\n\n**Cookies**\n\nCookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your devices internal memory.\n\nThis Service does not use these cookies explicitly. However, the app may use third party code and libraries that use cookies to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.\n\n**Service Providers**\n\nI may employ third-party companies and individuualls due to the following reasons:\n\n* To facilitate our Service;\n* To provide the Service on our behalf;\n* To perform Service-related service; or\n* To assist us in analyzing how our Service is used.\n\nI want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf.However, they are obligated not to disclose or use the information for any other purpose.\n\n**Security**\n\nI value your trust providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarentee its absolute security\n\n**Links to Other Sites**\n\nThis service may contains links of other sites. If you click on a third-party link,you will be directed to that site. Note that these external sites is not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content,privacy policies, or practicles of any third-party sites or services.\n\n**Children’s Privacy**\n\nThese Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do necessary actions.\n\n**Changes to This Privacy Policy**\n\nI may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.\n\nThis policy is effective as of 2021-11-10\n\n**Contact Us**\n\nIf you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at\nPicsD@gmail.com.",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
