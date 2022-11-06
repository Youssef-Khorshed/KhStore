const String cashedProducts = 'cashed';
const String apifailure = "data not respond";
const String cashfailure = "not cashed data";
const String authfailure = "username or password is wrong";
const String internetfailure = "No Internet Connection";
const String unexpectedfailure = "Opps something is woring please try again..!";
const String productAddedSuccess = "Product Added Successfully..!";
const String productGetSuccess = "Product Get Successfully..!";
const String productDeletedSuccess = "Product Deleted Successfully..!";
const String productUpdatedSuccess = "Product Updated Successfully..!";
const String getcategoriesSuccess = "Loaded Category items";
const String userpasswrordkey = "password";
const String usertokenkey = "token";
const String cartkey = 'CashedCart';
const String favitemskey = 'favitems';
const String pageviewkey = 'pageview';
String applang = 'en';
String personprofile =
    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const String egyptflag =
    'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/e0dfafce-ee81-4e44-8049-8e3f25e5bd57/d6vpi1u-cc4ae2f5-dc5f-43fe-8770-bb7b8b8a8f9a.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTpmaWxlLmRvd25sb2FkIl0sIm9iaiI6W1t7InBhdGgiOiIvZi9lMGRmYWZjZS1lZTgxLTRlNDQtODA0OS04ZTNmMjVlNWJkNTcvZDZ2cGkxdS1jYzRhZTJmNS1kYzVmLTQzZmUtODc3MC1iYjdiOGI4YThmOWEucG5nIn1dXX0.S-m6MGSHE4gegotAMeNRntd7Kow4Kz56Sblvo_jfjaY';
const String usflag =
    'https://tse1.mm.bing.net/th?id=OIP.Jtg-Y2nWrLAEED0hgSIrIgHaD_&pid=Api&P=0';
const String defaultimg =
    'https://wegotthiscovered.com/wp-content/uploads/2022/05/Spy-x-Family-anya-1200x675.png';
const String baseUrl = 'https://student.valuxapps.com/api/';
const String pageviewImg1 =
    'https://drive.google.com/uc?export=view&id=1zhSdES1D_2YAjDXGutOjDDOLKxg1UqEj';
const String pageviewImg2 =
    'https://drive.google.com/uc?export=view&id=12x0WWHzPw8SEYbTxJK5ag4JBj5t6dQp8';
const String pageviewImg3 =
    'https://drive.google.com/uc?export=view&id=1ARQS_gXDAbSDkRw6YNV6RKkFf7Dj-w_m';

Map<String, String> headers({String? token}) {
  return {
    'lang': 'en',
    'Content-type': 'application/json',
    'Authorization': token ?? ''
  };
}
