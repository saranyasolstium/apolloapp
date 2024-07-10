import '../../model/clinic_model.dart';
import '../../utils/global.dart';

class ClinicGlobalScreen {
  Future<void> storeData() async {
    ClinicModel model = ClinicModel();
    //Tamilnadu
    model.id = 1;
    model.clinicName = 'Apollo clinic, T. Nagar';
    model.state = 'Tamilnadu';
    model.city = 'Chennai';
    model.pincode = 600017;
    model.latitude = 13.0400596;
    model.longitude = 80.2380421;
    model.phone = 0;
    model.address =
        'Infinite Store, C/o Apollo clinic, Door No 11, 4, Sivaprakasam St, '
        'opposite to Brilliant Tutorial, Pondy Bazaar,'
        ' Parthasarathi Puram, T. Nagar, Chennai, Tamil Nadu 600017';

    tamilList.add(model);
    ClinicModel model2 = ClinicModel();
    model2.id = 2;
    model2.clinicName = 'Apollo Clinic, Velachery';
    model2.state = 'Tamilnadu';
    model2.city = 'Chennai';
    model2.pincode = 600042;
    model2.latitude = 12.97897957;
    model2.longitude = 80.22529363;
    model2.phone = 9154302721;
    model2.address =
        'Apollo Clinic, Plot no:46, 7th street, Near Vijayanagar bus stand, Tansi nagar,Velachery, Chennai, Tamil Nadu 600042';
    tamilList.add(model2);

    ClinicModel model3 = ClinicModel();
    model3.id = 3;
    model3.clinicName = 'Apollo Medical Centre, Anna Nagar';
    model3.state = 'Tamilnadu';
    model3.city = 'Chennai';
    model3.pincode = 600012;
    model3.latitude = 13.08495005;
    model3.longitude = 80.22172281;
    model3.phone = 9154302721;
    model3.address =
        'Apollo Medical Centre, #30, F- Block, 2nd Avenue,Anna Nagar East, Chennai, Tamil Nadu 600012';
    tamilList.add(model3);

    ClinicModel model4 = ClinicModel();
    model4.id = 4;
    model4.clinicName = 'Apollo Clinic, Valasarivakkam';
    model4.state = 'Tamilnadu';
    model4.city = 'Chennai';
    model4.pincode = 600087;
    model4.latitude = 13.04223744;
    model4.longitude = 80.18117907;
    model4.phone = 9154302721;
    model4.address =
        '1&2, Prakasam Rd, Near McDonald, Chowthri Nagar, Valasaravakkam, Chennai,Tamil Nadu 600087';
    tamilList.add(model4);

    // ClinicModel model5 = ClinicModel();
    // model5.id = 5;
    // model5.clinicName = 'Perungudi';
    // model5.state = 'Tamilnadu';
    // model5.city = 'Chennai';
    // model5.pincode = 600096;
    // model5.latitude = 12.96401995;
    // model5.longitude = 80.24579781;
    // model5.phone = 9154978510;
    // model5.address =
    //     'PN 111, DN 7, Thirumalai nagar Annexe,OMR Perungudi,chennai 600096';
    // tamilList.add(model5);
    //
    // //Telungana
    //
    // ClinicModel model6 = ClinicModel();
    // model6.id = 6;
    // model6.clinicName = ' Apollo Clinic Kondapur';
    // model6.state = 'Telungana';
    // model6.city = 'Hyderabad';
    // model6.pincode = 500084;
    // model6.latitude = 17.459723;
    // model6.longitude = 78.365889;
    // model6.phone = 9154978507;
    // model6.address =
    //     'Infinite Store, C/o Apollo Clinic, Gachibowli - Miyapur Rd RTC cross road, beside Swagth De-Royal Restaurants, Kothaguda, Hyderabad 500084';
    // telunganaHList.add(model6);

    ClinicModel model5 = ClinicModel();

    model5.id = 5;
    model5.clinicName = 'Infinite - My6senses, Alkapur';
    model5.state = 'Telungana';
    model5.city = 'Hyderabad';
    model5.pincode = 500089;
    model5.latitude = 17.391039704123916;
    model5.longitude = 78.36801501670001;
    model5.phone = 18602580123;
    model5.address =
        '	Infinite Store, Beside Dominos Pizza, Survey No 105, B-Block, Ground Floor, Plot No 37, Alkapur Township, Neknampur Village, Hyderabad - 500089';
    telunganaHList.add(model5);

ClinicModel model6 = ClinicModel();

    model6.id = 6;
    model6.clinicName = 'Infinite - My6senses, Miyapur';
    model6.state = 'Telungana';
    model6.city = 'Hyderabad';
    model6.pincode = 500049; 
    model6.latitude = 17.495491701837622;
    model6.longitude = 78.3566029827984;
    model6.phone = 18602580123;
    model6.address =
        'Infinite Store, Next to Pizza Hut, Jayabharathi Kalpana, Mumbai Highway, Nandini Nagar, Miyapur, Hyderabad – 500049';
    telunganaHList.add(model6);

ClinicModel model11 = ClinicModel();
    model11.id = 11;
    model11.clinicName = 'Apollo Clinic, Kondapur';
    model11.state = 'Telungana';
    model11.city = 'Hyderabad';
    model11.pincode = 500033;
    model11.latitude = 17.460135114845613;
    model11.longitude =  78.365725584654;
    model11.phone = 18602580123;
    model11.address =
        'Infinite Store, C/o Apollo Clinic, Gachibowli - Miyapur Rd RTC cross road, beside Swagth De-Royal Restaurants, Kothaguda, Hyderabad';

    telunganaHList.add(model11);
   

    ClinicModel model7 = ClinicModel();

    model7.id = 7;
    model7.clinicName = 'Apollo clinic Chandanagar';
    model7.state = 'Telungana';
    model7.city = 'Hyderabad';
    model7.pincode = 500040;
    model7.latitude = 17.4948;
    model7.longitude = 78.34414;
    model7.phone = 18602580123;
    model7.address =
        '	Infinite store, C/o Apollo Clinic,H No.1-58/91,Suresh Square,Seri Mandal, Chandanagar, Hyderabad 500040';
    telunganaHList.add(model7);

    ClinicModel model8 = ClinicModel();
    model8.id = 8;
    model8.clinicName = 'Apollo clinic Nizampet';
    model8.state = 'Telungana';
    model8.city = 'Hyderabad';
    model8.pincode = 500090;
    model8.latitude = 17.511351;
    model8.longitude = 78.384167;
    model8.phone = 18602580123;
    model8.address =
        'Infinite Store, C/o Apollo Clinic, # 239, Ground Floor, Near Bhavyas Anandam Apartments, Nizampet , Hyderabad, Telangana 500090';
    telunganaHList.add(model8);

      ClinicModel model12 = ClinicModel();
    model12.id = 12;
    model12.clinicName = 'Apollo Clinic, Manikonda';
    model12.state = 'Telungana';
    model12.city = 'Hyderabad';
    model12.pincode = 500033;
    model12.latitude = 17.406414157210573 ;
    model12.longitude = 78.39198118675901;
    model12.phone = 18602580123;
    model12.address = 'Infinite Store, C/o Apollo Clinic, #284, Shaikpet Main Rd, near Bhema Restaurant, OU Colony, Shaikpet, Manikonda, Telangana ';

    telunganaHList.add(model12);


    ClinicModel model9 = ClinicModel();
    model9.id = 9;
    model9.clinicName = 'Apollo Hospitals, Jubilee Hills';
    model9.state = 'Telungana';
    model9.city = 'Manikonda';
    model9.pincode = 500089;
    model9.latitude = 17.40597;
    model9.longitude = 78.392148;
    model9.phone = 18602580123;
    model9.address =
        'Film Nagar, Jubilee Hills, Hyderabad, Telangana State ';

    telunganaHList.add(model9);

    //    ClinicModel model10 = ClinicModel();
    // model10.id = 10;
    // model10.clinicName = 'Apollo Clinic AS Rao Nagar';
    // model10.state = 'Telungana';
    // model10.city = 'Secunderabad';
    // model10.pincode = 500062;
    // model10.latitude = 17.48173885;
    // model10.longitude = 78.55494592;
    // model10.phone = 8121013078;
    // model10.address =
    //     'Infinite Store, C/o Apollo Clinic, Rishab heights, above vodafone store, beside KFC, Trimulgherry - ECIL Rd, A. S. Rao Nagar, Secunderabad, Telangana 500062';

    // telunganaSList.add(model10);
    
    ClinicModel model13 = ClinicModel();
    model13.id = 13;
    model13.clinicName = 'Apollo Hospitals, Secunderabad';
    model13.state = 'Telungana';
    model13.city = 'Secunderabad';
    model13.pincode = 500003;
    model13.latitude = 17.429825;
    model13.longitude = 78.563843;
    model13.phone = 7207955886;
    model13.address =
        "Pollicetty Towers, St. John's Road, beside Keyes High School, Secunderabad, Telangana 500003";
    telunganaSList.add(model13);

    ClinicModel model14 = ClinicModel();
    model14.id = 14;
    model14.clinicName = 'Apollo Health City, Vishakhapatnam';
    model14.state = 'Telungana';
    model14.city = 'Vizag';
    model14.pincode = 530040;
    model14.latitude = 17.761193;
    model14.longitude = 78.317219;
    model14.phone = 7207955890;
    model14.address = 'Plot No:1, Arilova, Chinagadali 530040';
    andhraPradeshList.add(model14);

    
    //Karnataka

    ClinicModel model16 = ClinicModel();
    model16.id = 16;
    model16.clinicName = 'Apollo clinic Bellandur';
    model16.state = 'Karnataka';
    model16.city = 'Bengaluru';
    model16.pincode = 560103;
    model16.latitude = 12.926193;
    model16.longitude = 77.676654;
    model16.phone = 9154978940;
    model16.address =
        'Infinite store, Apollo Clinic, Bellandur, 74/1, Service Rd, Near Soul Space Spirit Central Mall, Bellandur, Bengaluru, Karnataka 560103';

    karnatakaList.add(model16);

    ClinicModel model17 = ClinicModel();
    model17.id = 17;
    model17.clinicName = 'Apollo clinic HSR Layout';
    model17.state = 'Karnataka';
    model17.city = 'Bengaluru';
    model17.pincode = 560102;
    model17.latitude = 12.91312;
    model17.longitude = 77.63657;
    model17.phone = 9154302720;
    model17.address =
        'Infinite Store, C/o Apollo clinic, Audiology department, 1st floor, 54, 12th Main Rd, above SBI Bank, HSR Layout, Bengaluru, Karnataka 560102';

    karnatakaList.add(model17);
    ClinicModel model18 = ClinicModel();
    model18.id = 18;
    model18.clinicName = 'Apollo clinic Indira nagar';
    model18.state = 'Karnataka';
    model18.city = 'Bengaluru';
    model18.pincode = 560038;
    model18.latitude = 12.9656384;
    model18.longitude = 77.64176223;
    model18.phone = 9154302446;
    model18.address =
        '	Infinite Store, C/o Apollo clinic, 1st floor, plot 2012, 100 Feet Rd, next to Starbucks, Above Vision Express India, HAL 2nd Stage, Indiranagar, Bengaluru, Karnataka 560038';

    karnatakaList.add(model18);

    ClinicModel model19 = ClinicModel();
    model19.id = 19;
    model19.clinicName = 'Apollo clinic JP nagar';
    model19.state = 'Karnataka';
    model19.city = 'Bengaluru';
    model19.pincode = 560078;
    model19.latitude = 12.89224012;
    model19.longitude = 77.58111778;
    model19.phone = 0;
    model19.address =
        '	Infinite Store, C/o Apollo Clinic, Room no 22 BNR complex, Near, Brigade Millenium Rd, Puttenahalli, JP Nagar 7th Phase, J. P. Nagar, Bengaluru, Karnataka 560078';

    karnatakaList.add(model19);

    ClinicModel model20 = ClinicModel();
    model20.id = 20;
    model20.clinicName = 'Apollo clinic Electronic city';
    model20.state = 'Karnataka';
    model20.city = 'Bengaluru';
    model20.pincode = 560100;
    model20.latitude = 12.84173772;
    model20.longitude = 77.64699244;
    model20.phone = 8121012230;
    model20.address =
        '	Infinite Store, C/o Apollo Clinic ,, Neeladri Rd, Karuna Nagar,Electronics City Phase 1, Electronic City, Bengaluru, Karnataka 560100';

    karnatakaList.add(model20);

    ClinicModel model21 = ClinicModel();
    model21.id = 21;
    model21.clinicName = 'Apollo Clinic Mysore';
    model21.state = 'Karnataka';
    model21.city = 'Mysuru';
    model21.pincode = 570002;
    model21.latitude = 12.32467;
    model21.longitude = 76.62398;
    model21.phone = 9154978502;
    model21.address =
        'Infinite Store, C/o Apollo Clinic #23, Panchavati Circle, Kalidasa Rd, Vani Vilas Mohalla, Mysuru, Karnataka 570002';

    karnatakaList2.add(model21);

    ClinicModel model22 = ClinicModel();
    model22.id = 22;
    model22.clinicName = 'Apollo Clinic Marathahalli';
    model22.state = 'Karnataka';
    model22.city = 'Bengaluru';
    model22.pincode = 560066;
    model22.latitude = 12.95643385;
    model22.longitude = 77.7168479;
    model22.phone = 9154302722;
    model22.address =
        'Infinite Store, C/o Apollo Clinic, 673/A,Shriram Samruddhi Apartments, Varthur Road, Near Kundalahalli Signal, Whitefield, BEML Layout, Brookefield, Bengaluru, Karnataka 560066';

    karnatakaList.add(model22);

    ClinicModel model23 = ClinicModel();
    model23.id = 23;
    model23.clinicName = 'Sheshadripuram';
    model23.state = 'Karnataka';
    model23.city = 'Bengaluru';
    model23.pincode = 560020;
    model23.latitude = 12.988152;
    model23.longitude = 77.573926;
    model23.phone = 7207955891;
    model23.address =
        'Old No. 28, 1, Platform Rd, Near Mantri Square Mall, Seshadripuram,Bengaluru, Karnataka 560020';

    karnatakaList.add(model23);

    ClinicModel model24 = ClinicModel();
    model24.id = 24;
    model24.clinicName = 'AH Mysore';
    model24.state = 'Karnataka';
    model24.city = 'Mysuru';
    model24.pincode = 570023;
    model24.latitude = 12.29613;
    model24.longitude = 76.63258;
    model24.phone = 9154978503;
    model24.address = 'Adichunchanagiri Road, Jayanagar, Kuvempu Nagara 570023';
    karnatakaList2.add(model24);

    //Maharastra

    ClinicModel model25 = ClinicModel();
    model25.id = 25;
    model25.clinicName = 'Apollo clinic Kharadi';
    model25.state = 'Maharastra';
    model25.city = 'Pune';
    model25.pincode = 411014;
    model25.latitude = 18.55169281;
    model25.longitude = 73.93674428;
    model25.phone = 7207955891;
    model25.address =
        'Infinite Store, C/o Apollo Clinic, Audiology department, #102,B Wing, 1st Floor, Kul Scapes, Magarpatta Road, '
        'Opp. Reliance Smart, Kharadi, Pune, Maharashtra 411014';

    maharastraPList.add(model25);

    ClinicModel model26 = ClinicModel();
    model26.id = 26;
    model26.clinicName = 'Apollo clinic Viman nagar';
    model26.state = 'Maharastra';
    model26.city = 'Pune';
    model26.pincode = 411014;
    model26.latitude = 18.55178;
    model26.longitude = 73.93673;
    model26.phone = 9154302719;
    model26.address =
        'Infinite Store, C/oApollo Clinic Ground Nyati Millenium Premises S1 Datta Mandir Chowk, Viman Nagar, Pune, Maharashtra 411014';

    maharastraPList.add(model26);
    ClinicModel model27 = ClinicModel();
    model27.id = 27;
    model27.clinicName = 'Apollo Clinic Wanowrie';
    model27.state = 'Maharastra';
    model27.city = 'Pune';
    model27.pincode = 411048;
    model27.latitude = 18.47963;
    model27.longitude = 73.89632;
    model27.phone = 9154978522;
    model27.address =
        'Infinite Store, C/o Apollo Clinic, Plot no B-1, Amba Vatika Co-op Housing society, near Café Coffee Day, Khondawa Khurd, Pune, Maharashtra 411048';

    maharastraPList.add(model27);

    ClinicModel model28 = ClinicModel();
    model28.id = 28;
    model28.clinicName = 'Apollo Clinic Nigidi';
    model28.state = 'Maharastra';
    model28.city = 'Pune';
    model28.pincode = 411044;
    model28.latitude = 18.65639;
    model28.longitude = 73.7699;
    model28.phone = 9154978475;
    model28.address =
        'Infinite Store, C/o Apollo Clinic, Shop # 14 -20, City Pride building ,Below kotak mahindra bank Next to, Sant Dyaneshwar Chowk, Nigdi, Pune, Maharashtra 411044';

    maharastraPList.add(model28);
    ClinicModel model29 = ClinicModel();
    model29.id = 29;
    model29.clinicName = 'Apollo clinic Aundh';
    model29.state = 'Maharastra';
    model29.city = 'Pune';
    model29.pincode = 411007;
    model29.latitude = 18.55698;
    model29.longitude = 73.80881;
    model29.phone = 9154302445;
    model29.address =
        'Infinite Store, C/o Apollo Clinic,Centriole Building, 130, ITI Road, Above Star Bucks Coffee,Anand Park, Aundh, PUNE – 411 007, Maharashtra State, India';

    maharastraPList.add(model29);

    ClinicModel model30 = ClinicModel();
    model30.id = 30;
    model30.clinicName = 'Navi Mumbai';
    model30.state = 'Maharastra';
    model30.city = 'Mumbai';
    model30.pincode = 400614;
    model30.latitude = 19.022165;
    model30.longitude = 73.028055;
    model30.phone = 9154978504;
    model30.address =
        'lot # 13, Off Uran Road, Parsik Hill Rd, Sector 23, CBD Belapur 400614';

    maharastraMList.add(model30);
    ClinicModel model31 = ClinicModel();
    model31.id = 31;
    model31.clinicName = 'Navi Mumbai';
    model31.state = 'Maharastra';
    model31.city = 'Nashik';
    model31.pincode = 422003;
    model31.latitude = 20.01236686;
    model31.longitude = 73.81612263;
    model31.phone = 9154978476;
    model31.address =
        'Plot No. 1, Swaminarayan Nagar, New Adgaon Naka, Panchavati, near Lunge Mangal Karyalay, Nashik, Maharashtra 422003';

    maharastraNList.add(model31);
    //Madhya Pradesh

    ClinicModel model32 = ClinicModel();
    model32.id = 32;
    model32.clinicName = 'Ujjain';
    model32.state = 'Madhya Pradesh';
    model32.city = 'Ujjain';
    model32.pincode = 456010;
    model32.latitude = 23.17729313;
    model32.longitude = 75.78893364;
    model32.phone = 9154978478;
    model32.address =
        'Shop No 5 NAVKAR SQUARE, TEEN BATTI CHOURAHA,Free ganj,Ujjain 456010';

    mathyaPradeshList.add(model32);

    ClinicModel model33 = ClinicModel();
    model33.id = 33;
    model33.clinicName = 'ranibagh';
    model33.state = 'Madhya Pradesh';
    model33.city = 'Indore';
    model33.pincode = 452001;
    model33.latitude = 22.66903764;
    model33.longitude = 75.8814909;
    model33.phone = 9154978480;
    model33.address =
        'Sho no LG 3, 213-214 Lakshya Square,Infront of queens college, Khandwa Road, Ranibagh 452001';
    mathyaPradeshList2.add(model33);

    ClinicModel model34 = ClinicModel();
    model34.id = 34;
    model34.clinicName = 'Mhow';
    model34.state = 'Madhya Pradesh';
    model34.city = 'Kishanganj';
    model34.pincode = 453441;
    model34.latitude = 0;
    model34.longitude = 0;
    model34.phone = 9154978479;
    model34.address =
        'Hno:166,purana,AB road,Kishanganj,Infront of SBI kishanganj 453441';

    mathyaPradeshList3.add(model34);
    //Andhra Pradesh
    ClinicModel model35 = ClinicModel();
    model35.id = 35;
    model35.clinicName = 'Apollo Hospitals, Ramnagar';
    model35.state = 'Andhra Pradesh';
    model35.city = 'Visakhapatnam';
    model35.pincode = 530002;
    model35.latitude = 17.71739423;
    model35.longitude = 83.30914799;
    model35.phone = 9154978521;
    model35.address = 'Door No 10, Executive Court, 50-80, Waltair Main Rd, opp. Daspalla, Ram Nagar, Visakhapatnam, Andhra Pradesh 530002';
    andhraPradeshList.add(model35);
  }
}
