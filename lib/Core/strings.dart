String? token;
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
const String baseUrl = 'https://api.escuelajs.co/api/v1/';
const String pageviewImg1 =
    'https://drive.google.com/uc?export=view&id=1zhSdES1D_2YAjDXGutOjDDOLKxg1UqEj';
const String pageviewImg2 =
    'https://drive.google.com/uc?export=view&id=12x0WWHzPw8SEYbTxJK5ag4JBj5t6dQp8';
const String pageviewImg3 =
    'https://drive.google.com/uc?export=view&id=1ARQS_gXDAbSDkRw6YNV6RKkFf7Dj-w_m';
Map<String, String> headers = {
  'Content-type': 'application/json',
  'Authorization': token ?? ''
};